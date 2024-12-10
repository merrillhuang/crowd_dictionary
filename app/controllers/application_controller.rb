class ApplicationController < ActionController::Base
  skip_forgery_protection

  include Pundit::Authorization
  after_action :verify_authorized, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."

    redirect_back fallback_location: root_url
  end
end
