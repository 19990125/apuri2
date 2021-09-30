class UserImage < ApplicationRecord
   belongs_to :user
   attachment :image
end
