class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :signed_in_user

  def sign_in_redirect
    unless user_signed_in?
      redirect_to root_path
      flash[:danger] = "ログインしてください"
    end
  end

  private

  def signed_in_user
    @user = current_user if user_signed_in?
  end
end
