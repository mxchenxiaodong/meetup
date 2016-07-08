class Authentication

  # 这些是不需要用户登录即可访问的路由。
  @@routing = [
    ['GET', '/signup'],
    ['GET', '/login'],
    ['POST', '/login'],
    ['DELETE','/logout'],
    ['POST','/users'],
    ['GET', '/']
  ]

  def initialize(app)
    @app = app
  end

  # {
  #   "session_id"=>"c635b864347db2132bb3de70700c3941",
  #   "_csrf_token"=>"BVoVym/5BtUoUKh2ge7ndrtgooGz09T0Up+/nAmwEyg=",
  #   "user_id"=>1
  # }
  def call(env)
    @request = Rack::Request.new(env)

    session = @request.session.to_hash   # also env['rack.session'].to_hash

    if !skip_auth? and !logged_in?
      redirect_to('/login')
    else
      @app.call(env)
    end
  end

  private

  def logged_in?
    @request.session[:user_id].present?
  end

  # status不能是200,得是重定向。
  def redirect_to(url)
    [302, {"Location" => url, "Content-Type" => "text/html"}, [""]]
  end

  # TODO:将静态文件过滤。应该有更好的实现方式。
  def skip_auth?
    return true if @request.path.split('/')[1] == 'assets'

    method = request_method
    path = @request.path.sub(/\.\w+$/, '')
    result = @@routing.detect { |r| r[0] == method && r[1] == path }
    result.present?
  end

  # 获取HTTP请求的方法。
  def request_method
    return @request.request_method           if @request.request_method != 'POST'
    return @request.params['_method'].upcase if @request.params['_method']
    @request.request_method
  end

end