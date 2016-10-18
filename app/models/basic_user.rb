class BasicUser < ActiveRecord::Base
    attr_accessor :email, :password_digest, :display_name, :about_me
end
