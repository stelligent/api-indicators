require 'spec_helper'

describe Api::StatusesController do
  describe "GET #index" do
    it "returns an error" do
      get :index
      response.should_not be_success
    end
  end
end
