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
    let(:user) { FactoryGirl.create(user_type) }

    before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key) }

    context "as user" do
      let(:user_type) { :user }

      describe "PUT #update" do
        it "does nothing" do
          put :update, id: indicator.id, indicator: { custom_url: "http://localhost:3000" }
          expect(response.body).to eq(" ")
        end
      end
    end

    context "as admin" do
      let(:user_type) { :admin }

      describe "PUT #update" do
        it "updates" do
          put :update, id: indicator.id, indicator: { custom_url: "http://localhost:3000" }
          expect(response).to be_successful
          expect(indicator.reload.custom_url).to eq("http://localhost:3000")
        end
      end
    end
  end
end
