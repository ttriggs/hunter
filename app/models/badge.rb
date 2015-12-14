class Badge < ActiveRecord::Base
  belongs_to :listing
  belongs_to :badge_type

  validates_uniqueness_of :badge_type, scope: :listing
end
