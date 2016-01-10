module Hunter
  module Badging
    class AcceptsDirectCheckout
      BADGE = "Accepts DCO"
      DCO_STRING = "Reverb Direct Checkout" # FIXME

      def self.badge_listings(listings:)
        new(listings: listings).badge_listings
      end

      def initialize(listings:)
        @listings = listings
      end

      def badge_listings
        @listings.each do |listing|
          listing.add_badge(badge) if accepts_direct_checkout?(listing)
        end
      end

      private

      def accepts_direct_checkout?(listing)
        listing_details(listing).payment_methods.include?(DCO_STRING)
      end

      def listing_details(listing)
        Hunter::ReverbAPI::ListingDetails.details(listing: listing)
      end
    end
  end
end
