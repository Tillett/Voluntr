class Relationship < ApplicationRecord
    belongs_to :follower, foreign_key: "follower_id", class_name: "VolunteerUser"
    belongs_to :followed, foreign_key: "followed_id", class_name: "RequestUser"
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
