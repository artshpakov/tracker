class CreateIssues < ActiveRecord::Migration[5.0]
  def change
    create_table :issues do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false, default: Issue::StatusPending
      t.belongs_to :reporter
      t.belongs_to :assignee
      t.timestamps
    end
  end
end
