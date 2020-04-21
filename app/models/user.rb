class User < ApplicationRecord
  validates_presence_of :password_digest, require: true
  validates_confirmation_of :password
  validates :email, uniqueness: true, presence: true
  validates :api_key, uniqueness: true, presence: false

  has_secure_password
  has_secure_token :api_key
end
