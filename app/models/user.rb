class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates_presence_of :password_confirmation
  validates_presence_of :api_key
end
