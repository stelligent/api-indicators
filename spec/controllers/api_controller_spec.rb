require 'spec_helper'

describe ApiController do
  let(:user) { FactoryGirl.create(:user) }

  before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key) }

  describe "GET #show" do
    it "returns ok status" do
      get :show
      response.should be_success
    end
  end
end
