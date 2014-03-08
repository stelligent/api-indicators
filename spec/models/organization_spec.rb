require 'spec_helper'

describe Organization do
  let(:organization) { FactoryGirl.build(:organization) }

  subject { organization }

  it { should be_valid }

  describe "validations" do
    describe "without name" do
      let(:organization) { FactoryGirl.build(:organization, name: "") }
      it { should_not be_valid }
    end

    describe "duplicated name" do
      let!(:existing_organization) { FactoryGirl.create(:organization, name: "Double") }
      let(:organization) { FactoryGirl.build(:organization, name: "Double") }
      it { should_not be_valid }
    end
  end
end
