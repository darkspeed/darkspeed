# An admin user
class Admin < ApplicationRecord
  has_secure_password
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :password, confirmation: true
end
