class User < ApplicationRecord
  authenticates_with_sorcery!
  self.inheritance_column = :role

  before_create :generate_api_token

  def generate_api_token
    begin
      self.api_token = SecureRandom.hex
    end while self.class.exists?(api_token: api_token)
  end
end
