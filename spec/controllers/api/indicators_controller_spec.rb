require 'spec_helper'

describe Api::IndicatorsController do
  let(:service) { FactoryGirl.create(:service) }
  let(:project) { FactoryGirl.create(:project) }
  let(:indicator) { service.indicators.find_by_project_id(project.id) }

  describe "unauthorized" do
    describe "GET #index" do
      it "returns an error" do
        get :index
        expect(response).not_to be_success
      end
    end

    describe "GET #show" do
      it "returns an error" do
        get :show, id: indicator.id
        expect(response).not_to be_success
      end
    end

    describe "PUT #update" do
      it "returns an error" do
        put :update, id: indicator.id
        expect(response).not_to be_success
      end
    end
  end

  describe "authorized" do
    let(:user) { FactoryGirl.create(:user) }

    before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key) }

    describe "PUT #update" do
      it "updates and returns an indicator" do
        put :update, id: indicator.id, indicator: { custom_url: "http://localhost:3000" }
        expect(response).to be_success
      end
    end
  end
end
