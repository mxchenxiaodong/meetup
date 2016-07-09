class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login(user)
      redirect_back_or(topics_url)
    else
      flash[:danger] = '账号或密码错误'
      redirect_to login_url
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
