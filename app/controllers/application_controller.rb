class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def sign_in_redirect
    unless user_signed_in?
      redirect_to root_path
      flash[:danger] = "ログインしてください"
    end
  end
end
