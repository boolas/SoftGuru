require 'spec_helper'

describe Issue do
  it "has a valid factory" do
    expect(build(:issue)).to be_valid
  end

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of(:name).scoped_to(:project_id) }
  it { should validate_presence_of :issue_type }
  it { should ensure_inclusion_of(:issue_type).in_array([ "Bug", "Task", "Feature" ]) }
  it { should validate_presence_of :status }
  it { should ensure_inclusion_of(:status).in_array([ "Open", "Started", "Finished" ]) }

end
