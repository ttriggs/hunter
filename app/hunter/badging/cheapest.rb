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
        @listings.first.add_badge(BADGE) if @listings.first.present?
      end
    end
  end
end
