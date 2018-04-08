class Manager < User
  has_many :assigned_issues, class_name: Issue, foreign_key: :assignee_id

  def issues
    Issue.all.includes(:reporter)
  end
end
