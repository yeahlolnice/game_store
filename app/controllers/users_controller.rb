class UsersController < ApplicationController
    
    def show
        if params[:user_id].to_i > User.last.id
            redirect_to games_path
            flash[:alert] = "Could not find a user by id #{params[:user_id]}"
        else
            @user = User.find(params[:user_id])
            @games = @user.games
        end
    end
end
