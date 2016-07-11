
class V1::SessionsController < V1::BaseController

  def create
    user = User.find_by(email: create_params[:email])
    if user && user.authenticate(create_params[:password])
      self.current_user = user
      render json: { data: user.as_json(only: [:id, :email, :authentication_token])}
    else
      render json: { status: 401, :msg => "Authorization" }
    end
  end

  private
  def create_params
    params.require(:user).permit(:email, :password)
  end
end