# Idea: badge listings if their recent transactions
# are within lower 15% of PG historic price range
#

module Hunter
  module Badging
    class RecentSalesNearLowestPrice
      BADGE = "RecentSalesNearlLowestPrice"
      DATE_THRESHOLD_FOR_RECENT_SALES = 30.days.ago
      MAXIMUM_RECENT_TRANSACTIONS_TO_CONSIDER = 10

      def self.badge_listings(listings:)
        new(listings: listings).badge_listings
      end

      def initialize(listings:)
        @listings = listings
      end

      def badge_listings
        listings.each do |listing|
          listing.add_badge(BADGE) if should_badge?(listing)
        end
      end

      private

      attr_reader :listings

      def should_badge?(listing)
        Hunter::Badging::RecentSalesNearLowestPricePolicy.should_badge?(listing: listing)
      end
    end
  end
end
