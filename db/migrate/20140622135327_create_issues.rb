class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.text :description
      t.string :issue_type
      t.string :status
      t.references :project, index: true
      t.references :user, index: true
      t.column :owner_id, :integer

      t.timestamps
    end
  end
end
