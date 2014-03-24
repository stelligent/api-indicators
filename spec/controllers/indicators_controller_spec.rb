require 'spec_helper'

describe IndicatorsController do
  let(:project) { FactoryGirl.create(:project) }
  let(:service) { FactoryGirl.create(:service) }
  let(:indicator) { service.indicators.find_by_project_id(project.id) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    user.organization.projects << project
  end

  context "unauthorized" do
    describe "GET #index" do
      it "is not successful" do
        get :index
        expect(response).not_to be_successful
      end
    end

    describe "GET #show" do
      it "is not successful" do
        get :show, id: indicator
        expect(response).not_to be_successful
      end
    end
  end

  context "authorized" do
    before { session[:user_id] = user.id }

    describe "GET #index" do
      it "is successful" do
        get :index
        expect(response).to be_successful
      end
    end

    describe "GET #show" do
      it "is successful" do
        get :show, id: indicator
        expect(response).to be_successful
      end
    end
  end
end
