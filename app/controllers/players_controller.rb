class PlayersController < ApplicationController
    def index
        if   params[:page].present?
            @players = Player.page(params[:page]).order('created_at DESC')
        else
            @players = Player.all
        end
        
        @players = @players.select(:id,:given_name,:avg,:home_runs,:runs,:ops)
        render json: {success: true,players: @players}
    end
end
