class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_sign_in
    unless current_user
      flash[:alert] = "You must be logged in to do that"
    end
  end
end
