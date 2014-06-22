class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :user, :class_name => "User"
  belongs_to :owner, :class_name => "User"

  ISSUE_TYPE = [ "Bug", "Task", "Feature" ]
  ISSUE_STATUS = [ "Open", "Started", "Finished" ]

  validates :name, presence: true, uniqueness: { scope: :project_id }
  validates :issue_type, presence: true, inclusion: ISSUE_TYPE
  validates :status, presence: true, inclusion: ISSUE_STATUS
end
