require 'spec_helper'

describe API::V1::FragmentsController, :focus do
  describe '#create' do
    before do
      @user = create :user
      @user.generate_api_token!
    end

    it 'creates fragment with correct token' do
      lambda {
        post :create, fragment: {code: 'foo = bar', language: "ruby"}, api_token: @user.api_token
        response.code.should == "201"
      }.should change { Fragment.count }.by(1)
    end

    it "creates fragment with user's default language" do
      @user.settings["default_language"] = "ruby"
      @user.save!
      lambda {
        post :create, fragment: {code: 'foo = bar'}, api_token: @user.api_token
        response.code.should == "201"
      }.should change { Fragment.count }.by(1)
    end

    it 'return Not Acceptable with incorrect params' do
      lambda {
        post :create, fragment: {}, api_token: @user.api_token
        response.code.should == "406"
      }.should_not change { Fragment.count }
    end

    it 'returns unauthorized with incorrect token' do
      lambda {
        post :create, fragment: {code: 'foo = bar'}, api_token: ""
      }.should_not change { Fragment.count }
      response.code.should == "401"
    end
  end
end
