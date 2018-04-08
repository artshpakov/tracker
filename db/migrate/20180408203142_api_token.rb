class ApiToken < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :api_token, :string
    User.find_each { |user| user.update(api_token: user.generate_api_token) }
  end
end
