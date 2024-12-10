class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    authorize User
    sum = 0
    num_ratings = 0
    @avg_rating = 0
    @user.translated_words.each do |phrase|
      phrase.ratings.each do |rating|
        sum += rating.rating_val.to_f
        num_ratings += 1
      end
    end
    
    if num_ratings > 0
      @avg_rating = (sum / num_ratings).truncate(2)
    end

    @translations = @user.translated_words.page(params[:page]).per(4)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:id)
  end
end
