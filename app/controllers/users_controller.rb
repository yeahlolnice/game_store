class UsersController < ApplicationController
    
    def show
        @user = User.find(params[:user_id])
        @games = @user.games
    end
end
