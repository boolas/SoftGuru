require 'spec_helper'

describe Project do
  it "has a valid factory" do
    expect(FactoryGirl.build(:project)).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of :language }

end
