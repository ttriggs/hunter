class ListingsDecorator
  def self.decorate_collection(listings:)
    new(listings: listings).decorate_collection
  end

  def initialize(listings:)
    @listings = listings
  end

  def decorate_collection
    @listings.map do |listing|
      ListingDecorator.new(listing)
    end
  end
end
