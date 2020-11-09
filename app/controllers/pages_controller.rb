class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :profile]
  before_action :set_profile, only: [:profile, :library]
  

  def profile
    @user = User.find(params[:user_id])
    user.games.each ...
  end

  
  private
  
  def set_profile
    @user = User.find(params[:user_id])
  end

end
