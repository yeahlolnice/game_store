class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:buy]
  before_action :authenticate_user!, except: [:buy, :index]
  before_action :set_games, only: [:index, :library]
  before_action :set_user, only: [:library]
  before_action :set_game, only: [:buy, :update, :destroy]
  
  def index
    @games = Game.all
  end
  
  def library
    @games = @user.games
  end

  def show
    @game = Game.find(params[:id])
    p @game
    p params
  end

  def edit
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def update
    @game.update(set_game_params)
    redirect_to game_path(@game.id)
    # render json: params
  end

  def create
    @game = Game.create(set_game_params)
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
    render plain: 'Success'
  end

  def cancel
    render plain: 'not success'
  end

  private

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
