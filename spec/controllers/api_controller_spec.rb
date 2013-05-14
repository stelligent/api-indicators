require 'spec_helper'

describe ApiController do
  describe "GET #show" do
    it "returns ok status" do
      get :show
      response.should be_success
    end
  end
end
