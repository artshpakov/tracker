class User < ApplicationRecord
  authenticates_with_sorcery!
  self.inheritance_column = :role
end
