module Hunter
  class Listings
    delegate :map, to: :listings

    def initialize(search_results:)
      @search_results = search_results
    end

    def price_asc
      listings.sort_by(&:total_price)
    end

    def [](index)
      listings[index]
    end

    def total_matching_listings
      @search_results.total
    end

    def listings
      @_listings ||= @search_results.listings.map { |listing| Hunter::Listing.new(listing) }
    end
  end
end
