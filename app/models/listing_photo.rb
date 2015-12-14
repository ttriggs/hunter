class ListingPhoto < ActiveRecord::Base
  belongs_to :listing
  belongs_to :photo, dependent: :destroy

  validates_uniqueness_of :photo_id, scope: :listing_id
end
