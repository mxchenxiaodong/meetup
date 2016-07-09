require 'rails_helper'

RSpec.describe Topic, :type => :model do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @topic = user.topics.build(:content => "here is content")
  end

  subject { @topic }

  it { expect respond_to(:user_id) }
  it { expect respond_to(:title) }
  it { expect respond_to(:content) }

  it { expect respond_to(:user) }

  it { expect be_valid }

  describe "when user_id is not present" do
    before { @topic.user_id = nil }
    it { expect(@topic).not_to be_valid }
  end

  describe "when title is not present" do
    before { @topic.title = nil }
    it { expect(@topic).not_to be_valid }
  end

  describe "when content is not present" do
    before { @topic.content = nil }
    it { expect(@topic).not_to be_valid }
  end


  describe "topic associations" do
    let!(:newer_topic) do
      FactoryGirl.create(:topic, user: user, created_at: 1.day.ago)
    end

    let!(:older_topic) do
      FactoryGirl.create(:topic, user: user, created_at: 2.day.ago)
    end

    it "should have the right topic in the right order" do
      expect(user.topics.count).to eq(2)
    end
  end
end