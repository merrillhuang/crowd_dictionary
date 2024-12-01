class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  def show
    sum = 0
    num_ratings = 0
    @user.translated_words.each do |phrase|
      phrase.ratings.each do |rating|
        sum += rating.rating_val.to_f
        num_ratings += 1
      end
    end

    @average_rating = sum / num_ratings
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
