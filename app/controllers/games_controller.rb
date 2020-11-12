class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:buy]
  before_action :authenticate_user!, except: [:index, :show, :edit]
  before_action :set_games, only: [:index, :library]
  before_action :set_user, only: [:library]
  before_action :set_game, only: [:buy, :update, :destroy, :success]
  
  def index
    @games = Game.all
  end
  
  def library
    @games = @user.games
  end

  def show
    @game = Game.find(params[:id])
    
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
    @game = Game.new(set_game_params)
    @game.owner = current_user.username
    @game.approved = false
    @game.save()
    redirect_to game_path(@game.id)
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
  end

  def cancel
    render plain: 'not success'
  end

  private

  def add_game

  end

  def set_game_params
    params.require(:game).permit(:title, :description, :price, :picture)
  end
  
  def set_game
    @game = Game.find(params[:id])
  end 

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_games
    @games = Game.all
  end
end
