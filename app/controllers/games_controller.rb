class GamesController < ApplicationController
  before_action :set_user, only: [:edit, :new, :library]
  def index
    @games = Game.all
  end
  
  def library
    @games = @user.games
  end

  def show
    @game = Game.find(params[:game_id])
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
