class VolunteerUser < ApplicationRecord
  attr_accessor :remember_token
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_ZIP_REGEX = /\A\d{5}-\d{4}|\A\d{5}\z/
  
  before_save {self.email = email.downcase}
  validates :display_name, presence: true, length: {maximum: 60}
  validates :email, presence: true, length: {maximum: 150},
                 format: {with: VALID_EMAIL_REGEX},
                 uniqueness: {case_sensitive: false}
  validates :zip_code, presence: true, length: {maximum: 10},
                format: {with: VALID_ZIP_REGEX}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  has_one :availability
  has_one :user_scorecard
  has_many :skills
  has_many :notifications, :as => :user
  
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
  
  def review(skill, attit, enthu, relia)
    
    ##increase review count
    self.rev_count = self.rev_count + 1
    
    ##assign local variables
    count = self.rev_count
    
    ##average based on review count
    inverseCount = 1.0/count
    
    self.skill_proficiency =
      inverseCount * :skill_proficiency + (count - inverseCount) * skill
    self.attitude =
      inverseCount * :attitude + (count - inverseCount) * attit
    self.enthusiasm =
      inverseCount * :enthusiasm + (count - inverseCount) * enthu
    self.reliability =
      inverseCount * :reliability + (count - inverseCount) * relia
  end
end
