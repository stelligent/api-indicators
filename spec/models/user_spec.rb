require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  subject { user }

  it { should be_valid }

  describe "validations" do
    describe "without name" do
      let(:user) { FactoryGirl.build(:user, name: "") }
      it { should_not be_valid }
    end

    describe "with duplicated name" do
      let!(:existing_user) { FactoryGirl.create(:user, name: "doppelganger") }
      let(:user) { FactoryGirl.build(:user, name: "doppeLganger") }
      it { should_not be_valid }
    end
  end
end
