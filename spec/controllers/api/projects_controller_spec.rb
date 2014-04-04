require 'spec_helper'

describe Api::ProjectsController do
  let(:project) { FactoryGirl.create(:project) }

  describe "unauthorized" do
    describe "GET #index" do
      it "returns an error" do
        get :index
        expect(response).not_to be_successful
      end
    end

    describe "GET #show" do
      it "returns an error" do
        get :show, id: project.id
        expect(response).not_to be_successful
      end
    end

    describe "POST #create" do
      it "returns an error" do
        post :create
        expect(response).not_to be_successful
      end
    end

    describe "PUT #update" do
      it "returns an error" do
        put :update, id: project.id
        expect(response).not_to be_successful
      end
    end

    describe "DELETE #destroy" do
      it "returns an error" do
        delete :destroy, id: project.id
        expect(response).not_to be_successful
      end
    end
  end

  describe "authorized" do
    let(:user) { FactoryGirl.create(user_type) }

    before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key) }

    context "as user" do
      let(:user_type) { :user }

      describe "GET #index" do
        let(:project) { FactoryGirl.create(:project) }

        before do
          user.organization.projects << project
        end

        it "renders JSON of available projects" do
          get :index
          expect(response.body).to eq([{ id: project.id, name: project.name, description: "" }].to_json)
        end
      end

      describe "POST #create" do
        it "does nothing" do
          post :create, project: { name: "qvb" }
          expect(response.body).to eq(" ")
        end
      end

      describe "PUT #update" do
        it "does nothing" do
          put :update, id: project.id, project: { name: "qvb" }
          expect(response.body).to eq(" ")
        end
      end

      describe "DELETE #destroy" do
        it "does nothing" do
          delete :destroy, id: project.id
          expect(response.body).to eq(" ")
        end
      end
    end

    context "as admin" do
      let(:user_type) { :admin }

      describe "POST #create" do
        context "with invalid params" do
          it "returns an error" do
            post :create, project: { name: "" }
            expect(response).not_to be_successful
          end
        end

        context "with valid params" do
          it "creates and returns a project" do
            post :create, project: { name: SecureRandom.hex }
            expect(response).to be_successful
          end
        end
      end

      describe "PUT #update" do
        context "with invalid params" do
          it "returns an error" do
            put :update, id: project.id, project: { name: "" }
            expect(response).not_to be_successful
          end
        end

        context "with valid params" do
          it "updates and returns a project" do
            put :update, id: project.id, project: { name: SecureRandom.hex }
            expect(response).to be_successful
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys and returns a project" do
          delete :destroy, id: project.id
          expect(response).to be_successful
        end
      end
    end
  end
end
