class ListingsSearchResultsView
  attr_reader :saved_search

  delegate :total_matching_listings,
           to: :saved_search

  def initialize(saved_search: saved_search)
    @saved_search = saved_search
  end

  def listings
    @_listings ||= decorated_listings
  end

  private

  def decorated_listings
    Hunter::Listings.decorate_collection(listings: price_sorted_listings)
  end

  def price_sorted_listings
    Listing.for_saved_search(saved_search).cheapest_first
  end
end
