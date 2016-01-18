# Idea: highlight listings that have sold
# multiple times within 30 days
# This class preferentially badges listings marked
# as part of the 'low price group', but will badge the first 3
# if a low price group is not found
#

module Hunter
  module Badging
    class MultipleRecentSales
      include ActionView::Helpers::UrlHelper

      BADGE = "Recent Sales:"
      MINIMUM_RECENT_SALES_FOR_BADGE = 7
      DATE_THRESHOLD_FOR_RECENT_SALES = 30.days.ago

      def self.badge_listings(listings:)
        new(listings: listings).badge_listings
      end

      def initialize(listings:)
        @listings = listings
      end

      def badge_listings
        listings.each do |listing|
          listing.add_badge(badge(listing)) if listing_is_quick_recent_seller?(listing)
        end
      end

      private

      attr_reader :listings

      def badge(listing)
        link_to badge_text(listing), listing.price_guide_web_url, target: "_blank"
      end

      def badge_text(listing)
        [
          BADGE,
          total_recent_transactions(listing)
        ].join(" ")
      end

      def listing_is_quick_recent_seller?(listing)
        total_recent_transactions(listing) >= MINIMUM_RECENT_SALES_FOR_BADGE
      end

      def total_recent_transactions(listing)
        listing.transactions.after_date(date: DATE_THRESHOLD_FOR_RECENT_SALES).filtered_transactions.count
      end
    end
  end
end
