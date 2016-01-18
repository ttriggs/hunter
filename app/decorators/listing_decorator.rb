class ListingDecorator
  attr_reader :listing

  delegate :title,
           :web_url,
           :offers_enabled,
           :make,
           :product_price,
           :shipping_price,
           :total_price,
           :model,
           :listing_photos,
           :badges,
           :condition, to: :listing

  def initialize(listing)
    @listing = listing
  end

  def display_price
    "$#{'%.2f' % product_price}"
  end

  def display_shipping
    "$#{'%.2f' % shipping_price}"
  end

  def display_total
    "$#{'%.2f' % total_price}"
  end

  def condition_color
    ConditionColorsDecorator.color_class(condition)
  end

  def photos
    listing_photos
  end
end
