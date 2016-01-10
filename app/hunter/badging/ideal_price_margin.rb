# Idea: highlight listings that are underpriced compared to the
# next-cheapest items.
#
# A price margin/gap (price difference between two items in a price-sorted list)
# within the cheapest listings, this may indicate that an item can be
# easily resold - potentially for a profit.
#

module Hunter
  module Badging
    class IdealPriceMargin
      BADGE = "LowPriceGroup"
      MAX_LISTINGS_TO_CONSIDER = 4
      MINIMUM_PRICE_MARGIN_FOR_BADGE = 4 # USD

      def self.badge_listings(listings:)
        new(listings: listings).badge_listings
      end

      def initialize(listings:)
        @listings = listings
      end

      def badge_listings
        calculate_price_margins

        listings_to_badge.each do |listing|
          listing.add_badge(badges(listing.price_margin))
        end
      end

      private

      attr_reader :listings

      def badges(price_margin)
        [BADGE, "PriceMargin: $#{price_margin}"]
      end

      def calculate_price_margins
        cheapest_listings.each.with_index(1) do |listing, index|
          listing.price_margin = calculated_price_margin(current_listing: listing,
                                                         next_listing: listings[index])
        end
      end

      def calculated_price_margin(current_listing:, next_listing:)
        price_current = current_listing.total_price
        price_next_cheapest = next_listing.try(:total_price)
        return 0 unless price_next_cheapest.present?

        (price_next_cheapest - price_current).round(2)
      end

      # when stepping through cheapest listings, take all listings
      # in the LowPriceGroup
      def listings_to_badge
        return [] unless index_of_group_boundary_listing.present?

        cheapest_listings.take(index_of_group_boundary_listing + 1)
      end

      # Identify listing that defines the boundary of the LowPriceGroup
      def index_of_group_boundary_listing
        cheapest_listings.index do |listing|
          significant_price_margin?(listing.price_margin)
        end
      end

      def cheapest_listings
        @_cheapest_listings ||= listings.first(MAX_LISTINGS_TO_CONSIDER)
      end

      def significant_price_margin?(price_margin)
        price_margin >= MINIMUM_PRICE_MARGIN_FOR_BADGE
      end
    end
  end
end
