class RequestUser < ApplicationRecord
  attr_accessor :remember_token 
  has_many :request_posts, dependent: :destroy
  before_save {self.email = email.downcase}
  validates :display_name, presence: true, length: {maximum: 60}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_URL_REGEX = /\A(https*:\/\/www\.\w*\.[a-z]{2,}\/?\S*)?\z/i
  validates :email, presence: true, length: {maximum: 150},
                 format: {with: VALID_EMAIL_REGEX},
                 uniqueness: {case_sensitive: false}
  validates :website_address, format: {with: VALID_URL_REGEX}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  has_one :request_user_scorecard
  has_many :notifications, :as => :user
  
  def RequestUser.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = RequestUser.new_token
    update_attribute(:remember_digest, RequestUser.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def RequestUser.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
