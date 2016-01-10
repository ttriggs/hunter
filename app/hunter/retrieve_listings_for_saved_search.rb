# require_relative 'badging/badge_listings'

module Hunter
  class RetrieveListingsForSavedSearch
    attr_reader :saved_search

    def self.retrieve_listings(saved_search:)
      new(saved_search: saved_search).retrieve_listings
    end

    def initialize(saved_search:)
      @saved_search = saved_search
    end

    def retrieve_listings
      search_results.tap do |search_results|
        Hunter::Badging::BadgeListings.add_badges(listings: search_results.listings)
      end
    end

    def search_results
      Hunter::SearchListings.search(saved_search: @saved_search)
    end
  end
end
