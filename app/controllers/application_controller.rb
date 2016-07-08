class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  include SessionsHelper

  # 把此处的用户认证推到middleware那边做了。
  # before_action :logged_in_user
  # def skip_action?
  #   ["sessions", "home", "users#new", "users#create"].any? do |action|
  #     arg = action.split('#')
  #     if arg.length == 1
  #       arg[0] == params[:controller]
  #     else
  #       arg[0] == params[:controller] and arg[1] == params[:action]
  #     end
  #   end
  # end

  # def logged_in_user
  #   return if skip_action?

  #   unless logged_in?
  #     flash[:danger] = '请先登录'
  #     store_location
  #     redirect_to login_path
  #   end
  # end

end
