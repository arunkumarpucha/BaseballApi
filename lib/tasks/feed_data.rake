require 'json'
require 'net/http'
require 'active_support/core_ext/hash'
desc 'This task is to feed data in to db from the remote url'

task :base_ball_stats do 
    s = Net::HTTP.get_response(URI.parse('http://www.cafeconleche.org/examples/baseball/1998statistics.xml')).body

    result = JSON.parse(Hash.from_xml(s).to_json)
    season_obj = result["SEASON"]
    season_year = result["SEASON"]["YEAR"]
    season_record = Season.find_or_create_by(year: season_year)
    league_obj = result["SEASON"]["LEAGUE"] 
    league_obj.each do |league|
    league_name = league["LEAGUE_NAME"]
    
    league_record = season_record.leagues.find_or_create_by(league_name: league_name)
    division_obj = league["DIVISION"]
    
    division_obj.each do |division|
    division_name = division["DIVISION_NAME"]
    division_record = league_record.divisions.find_or_create_by(division_name: division_name)
    
    team_obj = division["TEAM"]
    team_obj.each do |team|
    team_name = team["TEAM_NAME"]
    team_city = team["TEAM_CITY"]
    team_record = division_record.teams.find_or_create_by(team_name: team_name,team_city: team_city)
    
    player_obj = team["PLAYER"]
    
    player_obj.each do |player|
    player_hash = player.transform_keys(&:downcase)
    player_hash["bs_errors"] = player_hash.delete("errors")
    player_record = team_record.players.find_or_create_by(player_hash)
    
    avg = (player_record.hits)/(player_record.at_bats) rescue nil
    
    #finding the opb value
    obp_numerator = player_record.hits+player_record.walks+player_record.hit_by_pitch  rescue nil
    obp_denominator = player_record.at_bats+player_record.walks+player_record.sacrifice_flies+player_record.hit_by_pitch  rescue nil
    obp = obp_numerator/obp_denominator  rescue nil
    
    #finding the slg value
    slg_numerator = (1*player_record.hits)+(2*player_record.doubles)+(3*player_record.triples)+(4*player_record.home_runs) rescue nil
    slg_denominator = player_record.at_bats  rescue nil
    slg = slg_numerator/slg_denominator  rescue nil
    
    #finding the ops value
    ops = obp+slg rescue nil
    if ops == nil
        ops = nil
    elsif ops.nan?
        ops = nil
    end
    
    if avg == nil
        avg = nil
    elsif avg.nan?
        avg = nil
    end
    
    
    player_record.update(avg: avg,ops: ops)
    end
    end
    end
    
    end

end