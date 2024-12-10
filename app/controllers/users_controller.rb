class UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    authorize User
    @avg_rating = AvgUserRating.call(@user)

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
