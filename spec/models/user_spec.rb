require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email) }

  it "returns user's full name as a string" do
    user = FactoryGirl.build_stubbed(:user, first_name: "Matt", last_name: "Dro")
    expect(user.fullname).to eq "Matt Dro"
  end
end
