class UserImage < ApplicationRecord
   belongs_to :user
   attachment :profile_image
end
