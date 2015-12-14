module Hunter
  class SearchListings
    MAXIMUM_LISTINGS  = 50
    LISTINGS_ENDPOINT = "listings"

    DEFAULT_PARAMS = {
                        condition: "used",
                        item_country: "US",
                        ships_to: "US",
                        page: "1",
                        per_page: MAXIMUM_LISTINGS,
                        accepts_gift_cards: true,
                        sort: "price|asc",
                        product_type: "effects-pedals"
                     }

    def self.search(saved_search:)
      new(saved_search: saved_search).parsed_search_results
    end

    def initialize(saved_search:)
      @saved_search = saved_search
    end

    def parsed_search_results
      JSON.parse(search_results).with_indifferent_access
    end

    private

    attr_reader :saved_search

    def search_results
      @_search_results ||= Hunter::ReverbAPI::Client.search(endpoint: LISTINGS_ENDPOINT, query: search_query)
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
