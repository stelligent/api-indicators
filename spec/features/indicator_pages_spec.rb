require 'spec_helper'

describe "Indicator pages" do
  before do
    @service = Service.find_or_create_by_name(SecureRandom.hex)
    @project = Project.find_or_create_by_name(SecureRandom.hex)
    @indicator = @service.indicators.find_by_project_id(@project.id)
  end

  subject { page }

  describe "index page" do
    before { visit root_path }

    it { should have_title "Status" }
    it { should have_link "Docs" }
    it { should have_xpath "//a[contains(@href, '#{indicator_path(@indicator)}')]" }

    describe "when indicator doesn't have a page" do
      before do
        @indicator.update_attributes(has_page: false)
        visit root_path
      end
      it { should_not have_xpath "//a[contains(@href, '#{indicator_path(@indicator)}')]" }
    end
  end

  describe "indicator page" do
    before do
      @indicator.update_attributes(has_page: true)
      visit indicator_path(@indicator)
    end

    it { should have_title "Status | #{@indicator.name}" }
    it { should have_selector "h2", text: @indicator.name }
    it { should have_selector "h4", text: "History" }
  end
end
