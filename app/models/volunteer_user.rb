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
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
  has_one :availability
  has_one :user_scorecard
  has_many :skills
  has_many :notifications, :as => :user
  has_many :volunteer_user_skills, dependent: :destroy
  has_many :skills, through: :volunteer_user_skills
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  
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
  
  def self.search(search)
    if search
        search.downcase!
          #all.select{|x| x.display_name.downcase! == search}
           where("LOWER(display_name) LIKE ? or LOWER(email) LIKE ?", "%#{search}%", "%#{search}%")
    else
      all
    end
  end
  
  def follow(other)
    active_relationships.create(followed_id: other.id)
  end
  
  def unfollow(other)
    active_relationships.find_by(followed_id: other.id).destroy
  end
  
  def following?(other)
    following.include?(other)
  end
  
  
end
