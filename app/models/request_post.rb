class RequestPost < ApplicationRecord
  belongs_to :request_user
  default_scope -> { order(created_at: :desc) }
  validates :request_user_id, presence: true
  validates :title, presence: true
  validates :location, presence: true
  validates :description, presence: true
  has_many :request_post_updates
  has_many :request_post_jobs
  
    def self.search(search)
    if search
        search.downcase!
          #all.select{|x| x.display_name.downcase! == search}
           where("LOWER(title) LIKE ? or LOWER(location) LIKE ?", "%#{search}%", "%#{search}%")
    else
      all
    end
  end
end
