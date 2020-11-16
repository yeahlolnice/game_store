class ReviewsController < ApplicationController
  before_action :set_reviews, only: [:show]
before_action :find_review, only: [:edit, :update, :destroy]
  def show
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(permit_params)
    @review.user = current_user.username
    @review.game_id = params[:id]
    @review.save
    update_game_rating(@review.game_id)
    redirect_to game_path(@review.game_id)
  end

  def edit
    if !user_signed_in?
      redirect_to new_user_session_path()
    else
      if current_user.username != @review.user
        redirect_to games_path()
      end
    end
  end

  def update
    @review.update(permit_params)
    redirect_to game_path(@review.game_id)
    # render json: params
  end

  def destroy
    @review.destroy
    redirect_to games_path()
  end

  private

  def permit_params
    params.permit(:title, :content, :rating)
  end

  def find_review
    @review = Review.find(params[:id])
  end

  def set_reviews
    @reviews = Review.where(params[:id])
  end

  def update_game_rating(game_id)
    avg = 0
    @reviews = Review.where(game_id: game_id)
    @reviews.each do |review|
      avg += review.rating
    end
    avg = avg / @reviews.size
    @game = Game.find(game_id)
    @game.update(avg_rating: avg)
  end
end
