module Hunter
  module Badging
    class Cheapest
      BADGE = "Cheapest"

      def self.badge_listings(listings:)
        new(listings: listings).badge_listings
      end

      def initialize(listings:)
        @listings = listings
      end

      def badge_listings
        cheapest_listing.add_badge(BADGE)
      end

      private

      def cheapest_listing
        @listings.price_asc.first
      end
    end
  end
end
