class Notification < ApplicationRecord
    belongs_to :request_user
    belongs_to :volunteer_user
end
