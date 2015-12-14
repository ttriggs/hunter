class BadgeType < ActiveRecord::Base
  has_many :badges
  has_many :listings, through: :badges

  validates :name, presence: true
  validates :description, presence: true
end
