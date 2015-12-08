module Hunter
  class SearchListings
    MAXIMUM_LISTINGS  = 50
    LISTINGS_ENDPOINT = "listings"

    module DefaultParams
      USED_CONDITION             = "condition=used"
      ITEM_IN_US                 = "item_country=US"
      SHIPS_TO_US                = "ships_to=US"
      FIRST_PAGE                 = "page=1"
      MAX_NUMBER_LISTINGS        = "per_page=#{MAXIMUM_LISTINGS}"
      ACCEPTS_GIFTCARDS          = "accepts_gift_cards=true"
      SORT_BY_PRICE_LOWEST_FIRST = "sort=price%7Casc"
      ALL = [
        USED_CONDITION,
        ITEM_IN_US,
        SHIPS_TO_US,
        FIRST_PAGE,
        MAX_NUMBER_LISTINGS,
        ACCEPTS_GIFTCARDS,
        SORT_BY_PRICE_LOWEST_FIRST
      ]
    end

    def self.search(saved_search:)
      new(saved_search: saved_search).search
    end

    def initialize(saved_search:)
      @saved_search = saved_search
    end

    def search
      JSON.parse(search_result)
    end

    private

    attr_reader :saved_search

    def search_result
      @_search_result ||= Hunter::ReverbAPI::Client.search(endpoint: LISTINGS_ENDPOINT, query: search_query)
    end

    def search_query
      (DefaultParams::ALL + saved_search_params).join("&")
    end

    def saved_search_params
        [
          query_string,
          make_string,
          max_price_string,
          min_price_string
        ]
    end

    def query_string
      "query=#{saved_search.query}"
    end

    def make_string
      return "" if saved_search.make.blank?
      "make=#{saved_search.make}"
    end

    def max_price_string
      "price_max=#{saved_search.max_price}"
    end

    def min_price_string
      "price_min=#{saved_search.min_price}"
    end
  end
end
