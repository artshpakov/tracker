class Regular < User
  has_many :issues, foreign_key: :reporter_id
end
