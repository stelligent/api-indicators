require 'spec_helper'

describe Api::ProjectsController do
  before { @project = Project.create(name: "Test project") }

  describe "unauthorized" do
    describe "#index" do
      before { get :index, nil }
      it "returns all projects" do
        response.should be_success
      end
    end

    describe "#show" do
      before { get :show, id: @project.id }
      it "returns one project" do
        response.should be_success
      end
    end

    describe "#create" do
      before { post :create }
      it "returns an error" do
        response.should_not be_success
      end
    end

    describe "#update" do
      before { put :update, id: @project.id }
      it "returns an error" do
        response.should_not be_success
      end
    end

    describe "#destroy" do
      before { delete :destroy, id: @project.id }
      it "returns an error" do
        response.should_not be_success
      end
    end
  end

  describe "authorized" do
    before { @auth = { authorization: ActionController::HttpAuthentication::Token.encode_credentials(User.find_by_name!("admin").api_key) } }

    describe "#create" do
      before { post :create, nil, @auth }
      it "creates and returns a project" do
        response.should be_success
      end
    end

    describe "#update" do
      before { put :update, { id: @project.id, project: { name: "Renamed test project" } }, @auth }
      it "creates and returns a project" do
        response.should be_success
      end
    end

    describe "#destroy" do
      pending
    end
  end
end
