require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) { FactoryGirl.create(:user) }

  subject { @user }
  it { expect respond_to(:name) }
  it { expect respond_to(:email) }
  it { expect respond_to(:password_digest) }
  it { expect respond_to(:topics) }
  it { expect be_valid } # 确保创建用户时时合法的。

  describe "when name is not present" do
    before { user.name = " " }
    it { expect(user).not_to be_valid }
  end

  describe "when name is too long" do
    before { user.name = "a" * 21 }
    it { expect(user).not_to be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      @user_with_same_email = user.dup
      @user_with_same_email.save
    end

    it { expect(@user_with_same_email).not_to be_valid }
  end
end