require 'spec_helper'

describe Api::ServicesController do
  let(:service) { FactoryGirl.create(:service) }

  describe "unauthorized" do
    describe "GET #index" do
      it "returns an error" do
        get :index
        response.should_not be_success
      end
    end

    describe "GET #show" do
      it "returns an error" do
        get :show, id: service.id
        response.should_not be_success
      end
    end

    describe "POST #create" do
      it "returns an error" do
        post :create
        response.should_not be_success
      end
    end

    describe "PUT #update" do
      it "returns an error" do
        put :update, id: service.id
        response.should_not be_success
      end
    end

    describe "DELETE #destroy" do
      it "returns an error" do
        delete :destroy, id: service.id
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
          post :create, service: { name: "" }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "creates and returns a service" do
          post :create, service: { name: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "PUT #update" do
      context "with invalid params" do
        it "returns an error" do
          put :update, id: service.id, service: { name: "" }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "updates and returns a service" do
          put :update, id: service.id, service: { name: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys and returns a service" do
        delete :destroy, id: service.id
        response.should be_success
      end
    end
  end
end
