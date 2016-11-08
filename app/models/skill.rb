class Skill < ApplicationRecord
    has_many :volunteer_user_skills, dependent: :destroy
    has_many :skills, through: :volunteer_user_skills
end
