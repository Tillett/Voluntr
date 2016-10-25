class RequestPost < ApplicationRecord
  belongs_to :request_user
  default_scope -> { order(created_at: :desc) }
  validates :request_user_id, presence: true
  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
