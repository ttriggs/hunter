class ListingsSearchResultsView

  def initialize(search_results: search_results)
    @search_results = search_results.with_indifferent_access
  end

  def total_matching_listings
    search_results[:total]
  end

  def listings
    @_listings ||= decorated_listings
  end

  private

  attr_reader :search_results

  def decorated_listings
    search_results[:listings].map do |listing|
      ListingDecorator.new(listing)
    end
  end
end
