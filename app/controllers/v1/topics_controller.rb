class V1::TopicsController < V1::BaseController

  def index
    @topics = Topic.includes(:user).order("created_at desc").page(page).per(10)

    render json: {:data => @topics.as_json( :only => [:title, :content, :content_html, :created_at],
                                            :include => {:user => {:only => [:id, :name]}})}
  end


  protected
  def page
    params[:page] || 1
  end

end