class VolunteerUserSkill < ApplicationRecord
  belongs_to :volunteer_user
  belongs_to :skill
end
