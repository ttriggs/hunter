module Hunter
  module ReverbAPI
    class SearchListings
      MAXIMUM_LISTINGS  = 20
      LISTINGS_ENDPOINT = "listings"

      DEFAULT_PARAMS = {
        condition: "used",
        page: "1",
        per_page: MAXIMUM_LISTINGS,
        sort: "price|asc",
        item_country: "US",
        product_type: "effects-pedals"
      }

      def self.search(saved_search:)
        new(saved_search: saved_search).search
      end

      def initialize(saved_search:)
        @saved_search = saved_search
      end

      def search
        SearchListingsResults.new(raw_search_results: search_results.body)
      end

      private

      attr_reader :saved_search

      def search_results
        @_search_results ||= Client.search(endpoint: LISTINGS_ENDPOINT, query: search_query)
      end

      def search_query
        DEFAULT_PARAMS.merge(saved_search_params).compact
      end

      def saved_search_params
        {
          query: saved_search.query,
          price_max: saved_search.max_price,
          price_min: saved_search.min_price,
          make: saved_search_make_value,
        }
      end

      def saved_search_make_value
        saved_search.make if saved_search.make.present?
      end
    end
  end
end
