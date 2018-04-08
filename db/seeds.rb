user    = Regular.create email: 'user@local.host', password: '123456'
manager = Manager.create email: 'manager@local.host', password: '123456'

user.reported_issues.create title: "First issue", assignee: manager, status: Issue::StatusInProgress
user.reported_issues.create title: "Another issue"
