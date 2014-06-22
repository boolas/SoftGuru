class AddIndexToIssues < ActiveRecord::Migration
  def change
    add_index "issues", ["owner_id"], name: "index_issues_on_owner_id"
  end
end
