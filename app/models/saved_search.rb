class SavedSearch < ActiveRecord::Base
  validates :query, presence: true
  validates :max_price, numericality: true, presence: true
  validates :min_price, numericality: true, presence: true

end
