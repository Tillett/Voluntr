class VolunteerUser < ApplicationRecord
  attr_accessor :remember_token
  
  before_save {self.email = email.downcase}
  validates :display_name, presence: true, length: {maximum: 60}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 150},
                 format: {with: VALID_EMAIL_REGEX},
                 uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 12}
  has_one :availability
  has_one :user_scorecard
  has_many :skills
  has_many :notifications
  
  def VolunteerUser.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = VolunteerUser.new_token
    update_attribute(:remember_digest, VolunteerUser.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def VolunteerUser.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
