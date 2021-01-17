class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :password, confirmation: { case_sensitive: true }
  validates_presence_of :email, :api_key

end
