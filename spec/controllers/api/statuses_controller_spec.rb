require 'spec_helper'

describe Api::StatusesController do
  describe "GET #index" do
    it "returns all statuses" do
      get :index
      response.should be_success
    end
  end
end
