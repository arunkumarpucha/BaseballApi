require 'json'
require 'net/http'
require 'active_support/core_ext/hash'
desc 'This task is to feed data in to db from the remote url'

task :base_ball_stats do 
    s = Net::HTTP.get_response(URI.parse('http://www.cafeconleche.org/examples/baseball/1998statistics.xml')).body
    
    result = JSON.parse(Hash.from_xml(s).to_json)
    # puts result
    season_obj = result["SEASON"]
   # puts season_obj
    s = Season.first
    puts "season obj is #{s.inspect}"
    season_year = result["SEASON"]["YEAR"]
    season_record = Season.find_or_create_by(year: season_year)
    league_obj = result["SEASON"]["LEAGUE"] 
    puts league_obj
    league_obj.each do |league|
        league_name = league["LEAGUE_NAME"]
        puts "++++++++++++++++++++++++++++"
        puts league_name
        puts "++++++++++++++++++++++++++++"
        league_record = season_record.leagues.find_or_create_by(league_name: league_name)
        division_obj = league["DIVISION"]

        division_obj.each do |division|
            division_name = division["DIVISION_NAME"]
            division_record = league_record.divisions.find_or_create_by(division_name: division_name)
            puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                puts "division_name is #{division_name}"
                puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
            team_obj = division["TEAM"]
            team_obj.each do |team|
                team_name = team["TEAM_NAME"]
                team_city = team["TEAM_CITY"]
                team_record = division_record.teams.find_or_create_by(team_name: team_name,team_city: team_city)
                puts "333333333333333333333333333333"
                puts "team_name is #{team_name}"
                puts "333333333333333333333333333333"
                player_obj = team["PLAYER"]

                player_obj.each do |player|
                    puts "44444444444444444444444444444"
                    base_ball_errors = player["errors"]
                    player_hash = player.transform_keys(&:downcase)
                    player_hash["bs_errors"] = player_hash.delete("errors")
                    puts player_hash
                    player_record = team_record.players.find_or_create_by(player_hash)
                    puts "44444444444444444444444444444"
                end
            end
        end

    end
    # division_obj = league_obj["DIVISION"]
    # team_obj = division_obj["TEAM"]


end