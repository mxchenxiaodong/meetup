require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET root" do
    it "should work " do
      get root_path
      expect(response).to have_http_status(200)
    end
  end


  # TODO:模拟用户登录。
  describe "GET /topics" do
    it "should work " do
      get topics_path
      expect(response).to have_http_status(302)
    end

    it "should have the title '话题列表' " do
      get topics_path
      # expect(response).to have_selector("title", text: "话题列表")
    end
  end
end
