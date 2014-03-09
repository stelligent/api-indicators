require 'spec_helper'

describe Api::ServicesController do
  let(:service) { FactoryGirl.create(:service) }

  describe "unauthorized" do
    describe "GET #index" do
      it "returns an error" do
        get :index
        expect(response).not_to be_successful
      end
    end

    describe "GET #show" do
      it "returns an error" do
        get :show, id: service.id
        expect(response).not_to be_successful
      end
    end

    describe "POST #create" do
      before { post :create, service: { name: "qvb" } }

      it "returns an error" do
        expect(response).not_to be_successful
      end

      it "doesn't create" do
        expect(Service.find_by_name("qvb")).not_to be_present
      end
    end

    describe "PUT #update" do
      before { put :update, id: service.id, service: { name: "qvb" } }

      it "returns an error" do
        expect(response).not_to be_successful
      end

      it "doesn't update" do
        expect(service.reload).not_to eq("qvb")
      end
    end

    describe "DELETE #destroy" do
      before { delete :destroy, id: service.id }

      it "returns an error" do
        expect(response).not_to be_successful
      end

      it "doesn't delete" do
        expect(service).to be_persisted
      end
    end
  end

  describe "authorized" do
    let(:user) { FactoryGirl.create(user_type) }

    before { request.env["HTTP_AUTHORIZATION"] = ActionController::HttpAuthentication::Token.encode_credentials(user.api_key) }

    context "as user" do
      let(:user_type) { :user }

      describe "POST #create" do
        it "does nothing" do
          post :create, service: { name: "qvb" }
          expect(response.body).to eq(" ")
        end
      end

      describe "PUT #update" do
        it "does nothing" do
          put :update, id: service.id, service: { name: "qvb" }
          expect(response.body).to eq(" ")
        end
      end

      describe "DELETE #destroy" do
        it "does nothing" do
          delete :destroy, id: service.id
          expect(response.body).to eq(" ")
        end
      end
    end

    context "as admin" do
      let(:user_type) { :admin }

      describe "POST #create" do
        context "with invalid params" do
          it "returns an error" do
            post :create, service: { name: "" }
            expect(response).not_to be_successful
          end
        end

        context "with valid params" do
          it "creates and returns a service" do
            post :create, service: { name: SecureRandom.hex }
            expect(response).to be_successful
          end
        end
      end

      describe "PUT #update" do
        context "with invalid params" do
          it "returns an error" do
            put :update, id: service.id, service: { name: "" }
            expect(response).not_to be_successful
          end
        end

        context "with valid params" do
          it "updates and returns a service" do
            put :update, id: service.id, service: { name: SecureRandom.hex }
            expect(response).to be_successful
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys and returns a service" do
          delete :destroy, id: service.id
          expect(response).to be_successful
        end
      end
    end
  end
end
