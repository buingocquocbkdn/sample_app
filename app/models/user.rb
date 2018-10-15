class User < ApplicationRecord
  before_save{email.downcase!}
  validates :name,  presence: true,
    length: {maximum: Settings.length_string.name_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.length_string.email_max},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  has_secure_password
  validates :password, presence: true,
    length: {minimum: Settings.length_string.pass_min}
end
