require 'spec_helper'

describe "Login pages" do
  let(:user) { FactoryGirl.create(:admin) }

  subject { page }

  before { visit root_path }

  it { should have_link "Log In", href: login_path }

  describe "login page" do
    before { click_link "Log In" }

    it { should have_title "Status | Log in" }
    it { should have_selector "h3", text: "Log in" }
  end

  describe "login" do
    before { click_link "Log In" }

    describe "with invalid credentials" do
      before { click_button "Log in" }

      it { should have_selector "h3", text: "Log in" }
    end

    describe "with valid credentials" do
      before do
        fill_in "Name", with: user.name
        fill_in "Password", with: user.password
        click_button "Log in"
      end

      it { should have_title "Status | User" }
      it { should have_link "Profile", href: user_path(user) }
      it { should have_link "API", href: docs_path }
      it { should have_link "Log Out", href: logout_path }
      it { should have_link "Edit", href: edit_user_path(user) }

      describe "docs page" do
        before { click_link "API" }

        it { should have_title "Status | Documentation" }
        it { should have_selector "h1", "REST API Documentation" }
      end

      describe "log out" do
        before { click_link "Log Out" }

        it { should have_title "Status" }
        it { should have_link "Log In" }
      end
    end
  end
end
