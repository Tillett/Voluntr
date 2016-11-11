class Relationship < ApplicationRecord
    belongs_to :follower, foreign_key: "follower_id", class_name: "RequestUser"
    belongs_to :followed, foreign_key: "followed_id", class_name: "VolunteerUser"
    validates :follower_id, presence: true
    validates :followed_id, presence: true
end
