module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  # 实现登录后的友好跳转。
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # store_location时，记得跳过注册登录页面。
  def skip_path?
    [login_url, new_user_url].any? { |path| path == request.original_url  }
  end

  # 只记录get请求的。避免post,delete等直接跳转发生错误。
  # 只在检查到没有登录时才记录该路径。
  def store_location
    if request.get? and !request.xhr? and skip_path?
      session[:forwarding_url] = request.original_url
    end
  end

end
