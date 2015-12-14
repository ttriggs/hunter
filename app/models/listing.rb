class Listing < ActiveRecord::Base
  belongs_to :saved_search

  has_many :photos, through: :listing_photos, dependent: :destroy
  has_many :listing_photos

  has_many :badges, dependent: :destroy
  has_many :badge_types, through: :badges

  validates :title, presence: true
  validates :url, presence: true
  validates :condition, presence: true
  validates :price_cents, numericality: true, presence: true
  validates :shipping_cents, numericality: true, presence: true
  validates :reverb_id, presence: true

  scope :for_saved_search, -> (saved_search) { where(saved_search_id: saved_search.id) }
  scope :cheapest_first, -> { order('price_cents + shipping_cents ASC') }
end
