class GamesController < ApplicationController
  before_action :set_user, only: [:edit, :show, :new]
  def index
    @games = Game.all
  end
  
  def library
    set_user.id
  end
  def show
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
