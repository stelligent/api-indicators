require 'spec_helper'

describe "Login pages" do
  subject { page }

  before { visit root_path }

  it { should have_link "Log in", href: login_path }

  describe "login page" do
    before { click_link "Log in" }

    it { should have_title "Status | Log in" }
    it { should have_selector "h3", text: "Log in" }
  end

  describe "login" do
    before { click_link "Log in" }

    describe "with invalid credentials" do
      before { click_button "Log in" }

      it { should have_selector "h3", text: "Log in" }
    end

    describe "with valid credentials" do
      before do
        fill_in "Name", with: "admin"
        fill_in "Password", with: "admin"
        click_button "Log in"
      end

      it { should have_title "Status | Profile" }
      it { should have_link "Profile", href: profile_path }
      it { should have_link "Log out", href: logout_path }
      it { should have_link "Edit", href: edit_profile_path }

      describe "log out" do
        before { click_link "Log out" }
        it { should have_link "Log in" }
      end
    end
  end
end
