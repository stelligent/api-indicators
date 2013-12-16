require 'spec_helper'

describe Api::IndicatorsController do
  let(:service) { Service.find_or_create_by_name(SecureRandom.hex) }
  let(:project) { Project.find_or_create_by_name(SecureRandom.hex) }
  let(:indicator) { service.indicators.find_by_project_id(project.id) }

  describe "unauthorized" do
    describe "GET #index" do
      it "returns all indicators" do
        get :index
        response.should be_success
      end
    end

    describe "GET #show" do
      it "returns one indicator" do
        get :show, id: indicator.id
        response.should be_success
      end
    end

    describe "PUT #update" do
      it "returns an error" do
        put :update, id: indicator.id
        response.should_not be_success
      end
    end
  end

  describe "authorized" do
    before do
      request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(User.find_by_name!("admin").api_key)
    end

    describe "PUT #update" do
      it "updates and returns an indicator" do
        put :update, id: indicator.id, indicator: { has_page: false }
        response.should be_success
      end
    end
  end
end
