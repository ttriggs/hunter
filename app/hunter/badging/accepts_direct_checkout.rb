module Hunter
  module Badging
    class AcceptsDirectCheckout
      BADGE = "Accepts DCO"
      DCO_STRING = "direct_checkout"

      def self.badge_listings(listings:)
        new(listings: listings).badge_listings
      end

      def initialize(listings:)
        @listings = listings
      end

      def badge_listings
        @listings.each do |listing|
          listing.add_badge(BADGE) if accepts_direct_checkout?(listing)
        end
      end

      private

      def accepts_direct_checkout?(listing)
        listing.listing_details.payment_methods.include?(DCO_STRING)
      end
    end
  end
end
