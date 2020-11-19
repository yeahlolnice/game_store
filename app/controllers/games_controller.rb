class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:buy]
  before_action :authenticate_user!, except: [:index, :show, :edit]
  before_action :set_games, only: [:index]
  before_action :set_user, only: [:library]
  before_action :set_game, only: [:buy, :update, :destroy, :success, :approved]
  
  def index
  end
  
  def library
    @games = @user.games
  end

  def show
    if params[:id].to_i > Game.last.id
      redirect_to games_path
      flash[:alert] = "Could not find a game by id #{params[:id]}"
    else
      @game = Game.find(params[:id])
      @reviews = Review.where(game_id: params[:id])
    end
  end

  def edit
    @game = Game.find(params[:id])
    @game_owner = User.find_by_username(@game.owner)
    if !user_signed_in?
      redirect_to new_user_session_path()
    else
      if current_user.id != @game_owner.id
        redirect_to games_path()
      end
    end
  end

  def update
    @game.update(set_game_params)
    redirect_to game_path(@game.id)
    # render json: params
  end

  def new
    @game = Game.new
  end
  
  def create
    @user = signed_in_user
    @game = Game.new(set_game_params)
    @game.owner = current_user.username
    @game.approved = false
    if @game.save
      redirect_to game_path(@game.id)
    else
      flash[:form_errors] = @game.errors.full_messages
      render "new"
      # redirect_to new_game_path
      # flash[:error] = "Must fill out every area in the form"
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path()
  end
  
  def buy
    Stripe.api_key = ENV['STRIPE_API_KEY']
    session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      mode: 'payment',
      success_url: success_url(params[:id]),
      cancel_url: cancel_url(params[:id]),
      line_items: [
        {
          price_data: {
            currency: 'aud',
            product_data: {
              name: @game.title
            },
            unit_amount: (@game.price.to_f * 100).to_i
          },
          quantity: 1
        }
      ]
    })

    render json: session
  end

  def success
    @user = User.find(current_user.id)
    @user.games.push(@game)
    redirect_to games_path
    flash[:alert] = "Your purchase was successful!"
  end

  def cancel
    redirect_to games_path
    flash[:alert] = "Payment was unsuccessful!"
  end
  
  def restricted
    if user_signed_in?
      if current_user.has_role?(:admin)
        @games = Game.where(approved: false)
      else
        redirect_to games_path
        flash[:alert] = "You dont have access to this page"
      end
    else
      redirect_to games_path
      flash[:alert] = "You dont have access to this page"
    end
  end

  def approved
    @game.update(approved: true)
    @user = User.find_by_username(@game.owner)
    @user.games.push(@game)
    # redirect_to game_path(@game.id)
    redirect_to games_restricted_path
  end

  private

  def add_game

  end

  def set_game_params
    params.require(:game).permit(:title, :description, :price, :picture, :game_folder)
  end
  
  def set_game
    @game = Game.find(params[:id])
  end 

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_games
    @games = Game.where(approved: true)
  end
  
  def signed_in_user
    @user = User.find(current_user.id)
  end
end
