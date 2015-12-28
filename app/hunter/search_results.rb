module Hunter
  class SearchResults
    def initialize(raw_search_results:)
      @raw_search_results = raw_search_results
    end

    def listings
      @_listings ||= new_price_sorted_listings
    end

    def total_matching_listings
      parsed_results["total"]
    end

    private

    attr_reader :raw_search_results

    def parsed_results
      JSON.parse(raw_search_results)
    end

    def new_price_sorted_listings
      parsed_results["listings"].map do |listing|
        Hunter::Listing.new(listing)
      end.sort_by(&:total_price)
    end
  end
end
