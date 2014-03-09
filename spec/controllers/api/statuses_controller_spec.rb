require 'spec_helper'

describe Api::StatusesController do
  context "unauthorized" do
    describe "GET #index" do
      it "returns an error" do
        get :index
        expect(response).not_to be_successful
      end
    end
  end

  context "authorized as user" do
    let(:user) { FactoryGirl.create(:user) }

    before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key) }

    describe "GET #index" do
      it "works" do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
