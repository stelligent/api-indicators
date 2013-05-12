require 'spec_helper'

describe Api::EventsController do
  before do
    @service = Service.find_or_create_by_name(SecureRandom.hex)
    @project = Project.find_or_create_by_name(SecureRandom.hex)
    @indicator = @service.indicators.find_by_project_id(@project.id)
    @status = Status.find_by_name("red")
    @event = @indicator.events.create(status_id: @status.id, message: SecureRandom.hex)
  end

  describe "unauthorized" do
    describe "GET #index" do
      it "returns all events" do
        get :index, indicator_id: @indicator.id
        response.should be_success
      end
    end

    describe "GET #show" do
      it "returns one event" do
        get :show, indicator_id: @indicator.id, id: @event.id
        response.should be_success
      end
    end

    describe "POST #create" do
      it "returns an error" do
        post :create, indicator_id: @indicator.id
        response.should_not be_success
      end
    end

    describe "PUT #update" do
      it "returns an error" do
        put :update, indicator_id: @indicator.id, id: @event.id
        response.should_not be_success
      end
    end

    describe "DELETE #destroy" do
      it "returns an error" do
        delete :destroy, indicator_id: @indicator.id, id: @event.id
        response.should_not be_success
      end
    end
  end

  describe "authorized" do
    before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(User.find_by_name!("admin").api_key) }

    describe "POST #create" do
      context "with invalid params" do
        it "returns an error" do
          post :create, indicator_id: @indicator.id, event: { status_id: nil, message: SecureRandom.hex }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "creates and returns an event" do
          post :create, indicator_id: @indicator.id, event: { status_id: @status.id, message: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "PUT #update" do
      context "with invalid params" do
        it "returns an error" do
          put :update, indicator_id: @indicator.id, id: @event.id, event: { status_id: nil, message: SecureRandom.hex }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "updates and returns an event" do
          put :update, indicator_id: @indicator.id, id: @event.id, event: { status_id: @status.id, message: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys and returns an event" do
        delete :destroy, indicator_id: @indicator.id, id: @event.id
        response.should be_success
      end
    end
  end
end
