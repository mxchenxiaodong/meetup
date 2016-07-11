class Api_Authentication

  # 这些是不需要用户登录即可访问的路由。
  @@routing = [
    ['POST', '/v1/login'],
  ]

  def initialize(app)
    @app = app
  end

  def call(env)
    @request = Rack::Request.new(env)
    if if_request_api? and !skip_auth? and !authenticate_user!
      api_error
    else
      @app.call(env)
    end
  end

  private

  def authenticate_user!
    return false if @request.params["token"].blank?
    return User.find_by(authentication_token: @request.params["token"]).present?
  end

  def if_request_api?
    return true if @request.path.split('/')[1] == 'v1'
  end

  def api_error
    [401, { 'Content-Type' => 'application/json' }, [ { :msg => "Authorization" }.to_json ]]
  end

  # TODO:将静态文件过滤。应该有更好的实现方式。
  def skip_auth?
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