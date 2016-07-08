class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      redirect_to topics_path
    else
      flash[:danger] = @user.errors.full_messages
      redirect_to signup_url
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end