class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:home, :profile]
  before_action :set_profile, only: [:profile, :library]
  def home
    
  end
  
  def library
    
  end

  def profile
    
  end

  
  private
  
  def set_profile
    @user = User.find(params[:user_id])
  end
end
