class ListingDecorator
  def initialize(listing)
    @listing = listing
  end

  def listing_web_url
    listing[:_links][:web][:href]
  end

  def make
    listing[:make]
  end

  def model
    listing[:model]
  end

  def finish
    listing[:finish]
  end

  def title
    listing[:title]
  end

  def created_at
    listing[:created_at]
  end

  def shop_name
    listing[:shop_name]
  end

  def description
    listing[:description]
  end

  def condition
    listing[:condition]
  end

  def price
    listing[:price]
  end

  def offers_enabled
    listing[:offers_enabled]
  end

  def state
    listing[:state]
  end

  def _links
    listing[:_links]
  end

  def shipping
    listing[:shipping]
  end

  def photos
    listing[:photo]
  end


  private

  attr_reader :listing
end
