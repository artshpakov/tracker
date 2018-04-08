class Issue < ApplicationRecord
  belongs_to :assignee, class_name: User
  belongs_to :reporter, class_name: User

  default_scope { order(created_at: :desc) }

  StatusPending = 1
  StatusInProgress = 2
  StatusResolved = 3

  DefaultStatus = StatusPending

  def has_assignee?
    assignee_id.present?
  end
end
