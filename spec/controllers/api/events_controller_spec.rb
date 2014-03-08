require 'spec_helper'

describe Api::EventsController do
  let(:service) { FactoryGirl.create(:service) }
  let(:project) { FactoryGirl.create(:project) }
  let(:indicator) { service.indicators.find_by_project_id(project.id) }
  let(:status) { FactoryGirl.create(:status) }
  let(:event) { FactoryGirl.create(:event, indicator: indicator, status: status) }

  describe "unauthorized" do
    describe "GET #index" do
      it "returns an error" do
        get :index, indicator_id: indicator.id
        response.should_not be_success
      end
    end

    describe "GET #show" do
      it "returns an error" do
        get :show, indicator_id: indicator.id, id: event.id
        response.should_not be_success
      end
    end

    describe "POST #create" do
      it "returns an error" do
        post :create, indicator_id: indicator.id
        response.should_not be_success
      end
    end

    describe "PUT #update" do
      it "returns an error" do
        put :update, indicator_id: indicator.id, id: event.id
        response.should_not be_success
      end
    end

    describe "DELETE #destroy" do
      it "returns an error" do
        delete :destroy, indicator_id: indicator.id, id: event.id
        response.should_not be_success
      end
    end
  end

  describe "authorized" do
    let(:user) { FactoryGirl.create(:admin) }

    before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key) }

    describe "POST #create" do
      context "with invalid params" do
        it "returns an error" do
          post :create, indicator_id: indicator.id, event: { status_id: nil, message: SecureRandom.hex }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "creates and returns an event" do
          post :create, indicator_id: indicator.id, event: { status_id: status.id, message: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "PUT #update" do
      context "with invalid params" do
        it "returns an error" do
          put :update, indicator_id: indicator.id, id: event.id, event: { status_id: nil, message: SecureRandom.hex }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "updates and returns an event" do
          put :update, indicator_id: indicator.id, id: event.id, event: { status_id: status.id, message: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys and returns an event" do
        delete :destroy, indicator_id: indicator.id, id: event.id
        response.should be_success
      end
    end
  end
end
