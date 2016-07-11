class V1::BaseController < ActionController::Base

  def current_user
    @current_user ||= User.find_by(authentication_token: params[:authentication_token])
  end

  def logged_in?
    current_user.present?
  end

end