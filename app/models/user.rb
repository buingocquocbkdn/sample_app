class User < ApplicationRecord
  attr_accessor :remember_token
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
    length: {minimum: Settings.length_string.pass_min},
    allow_nil: true

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def digest string
      if cost = ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
