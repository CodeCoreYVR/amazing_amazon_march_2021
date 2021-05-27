class ApplicationController < ActionController::Base

  private

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def authenticate_user!
    unless user_signed_in?
      flash[:danger] = "Sign in before trying that!"
      redirect_to new_session_path
    end
  end
end
