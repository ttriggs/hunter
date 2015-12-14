class ListingDecorator
  delegate :photos,
           :title,
           :url,
           :offers,
           :make,
           :price_cents,
           :shipping_cents,
           :model,
           :condition, to: :listing

  def initialize(listing)
    @listing = listing
  end

  def display_price
    "$#{'%.2f' % price_to_f}"
  end

  def display_shipping
    "$#{'%.2f' % shipping_to_f}"
  end

  def display_total
    "$#{'%.2f' % total_price}"
  end

  def total_price
    price_to_f + shipping_to_f
  end

  def condition_color
    ConditionColorsDecorator.color_class(listing.condition)
  end

  private

  attr_reader :listing

  def price_to_f
    listing.price_cents / 100.0
  end

  def shipping_to_f
    listing.shipping_cents / 100.0
  end
end
