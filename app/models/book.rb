class Book < ApplicationRecord

  belongs_to :user
  attachment :image

  validates :title, presence: true
  validates :opinion, presence: true
end
