class Photo < ActiveRecord::Base
  belongs_to :listing_photo
  validates :link, presence: true
end
