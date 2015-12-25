class ListingsSearchResultsView
  attr_reader :saved_search, :badged_listings

  delegate :total_matching_listings, to: :badged_listings

  def initialize(saved_search:, badged_listings:)
    @saved_search = saved_search
    @badged_listings = badged_listings
  end

  def listings
    @_listings ||= decorated_listings
  end

  private

  def decorated_listings
    ListingsDecorator.decorate_collection(listings: badged_listings.price_asc)
  end
end
