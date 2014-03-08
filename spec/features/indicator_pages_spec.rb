require 'spec_helper'

describe "Indicator pages" do
  let(:user) { FactoryGirl.create(:user) }
  let(:service) { FactoryGirl.create(:service) }
  let(:project) { FactoryGirl.create(:project) }
  let!(:indicator) { service.indicators.find_by_project_id(project.id) }

  before do
    user.organization.projects << project
    sign_in(user)
  end

  subject { page }

  describe "index page" do
    before { visit root_path }

    it { should have_title "Status" }
    it { should have_xpath "//a[contains(@href, '#{indicator_path(indicator)}')]" }
    it { should have_xpath "//img[@title='stelligent']" }
  end

  describe "indicator page" do
    before { visit indicator_path(indicator) }

    it { should have_title "Status | #{indicator.name}" }
    it { should have_selector "h2", text: indicator.name }
    it { should have_selector "h4", text: "History" }
  end
end
