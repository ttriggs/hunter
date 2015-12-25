require_relative 'badging/badge_listings'

module Hunter
  class ListingsFromSearchResults

    def self.create_listings(saved_search:)
      new(saved_search: saved_search).create_badged_listings
    end

    def initialize(saved_search:)
      @saved_search = saved_search
    end

    def create_badged_listings
      new_listings.tap do |listings|
        Hunter::Badging::BadgeListings.add_badges(listings: listings)
      end
    end

    private

    attr_reader :saved_search

    def search_results
      @_search_results ||= Hunter::SearchListings.search(saved_search: saved_search)
    end

    def new_listings
      Hunter::Listings.new(search_results: search_results)
    end
  end
end
