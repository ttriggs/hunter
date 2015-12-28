class ListingsSearchResultsView
  attr_reader :saved_search, :search_results

  delegate :total_matching_listings,
           :listings,
           to: :search_results

  def initialize(saved_search:, search_results:)
    @saved_search = saved_search
    @search_results = search_results
  end

  def listings
    @_listings ||= decorated_listings
  end

  private

  def decorated_listings
    ListingsDecorator.decorate_collection(listings: search_results.listings)
  end
end
