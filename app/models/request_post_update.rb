class RequestPostUpdate < ApplicationRecord
    belongs_to :request_post
    ERB_INJECTION_REGEX = /<%[= ].*%>/
    
    validates :text, presence: true,
        format: {without: ERB_INJECTION_REGEX}
end
