require 'spec_helper'

describe Api::ProjectsController do
  let(:project) { Project.find_or_create_by_name(SecureRandom.hex) }

  describe "unauthorized" do
    describe "GET #index" do
      it "returns all projects" do
        get :index
        response.should be_success
      end
    end

    describe "GET #show" do
      it "returns one project" do
        get :show, id: project.id
        response.should be_success
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
        put :update, id: project.id
        response.should_not be_success
      end
    end

    describe "DELETE #destroy" do
      it "returns an error" do
        delete :destroy, id: project.id
        response.should_not be_success
      end
    end
  end

  describe "authorized" do
    before do
      request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(User.find_by_name!("admin").api_key)
    end

    describe "POST #create" do
      context "with invalid params" do
        it "returns an error" do
          post :create, project: { name: "" }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "creates and returns a project" do
          post :create, project: { name: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "PUT #update" do
      context "with invalid params" do
        it "returns an error" do
          put :update, id: project.id, project: { name: "" }
          response.should_not be_success
        end
      end
      context "with valid params" do
        it "updates and returns a project" do
          put :update, id: project.id, project: { name: SecureRandom.hex }
          response.should be_success
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys and returns a project" do
        delete :destroy, id: project.id
        response.should be_success
      end
    end
  end
end
