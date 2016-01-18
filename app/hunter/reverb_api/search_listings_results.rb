module Hunter
  class SearchListingsResults
    def initialize(raw_search_results:)
      @raw_search_results = raw_search_results
    end

    def listings
      @_listings ||= badgeable_listings
    end

    def total_matching_listings
      parsed_results["total"]
    end

    private

    attr_reader :raw_search_results

    def parsed_results
      JSON.parse(raw_search_results)
    end

    def price_sorted_listings
      parsed_results["listings"].map do |listing|
        Hunter::Listing.new(listing)
      end.sort_by(&:total_price)
    end

    def badgeable_listings
      price_sorted_listings.select do |listing|
        Hunter::Badging::BadgingEligibilityPolicy.badgeable?(listing: listing)
      end
    end
  end
end
