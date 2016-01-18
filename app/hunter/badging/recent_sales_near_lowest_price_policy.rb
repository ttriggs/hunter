module Hunter
  module Badging
    class RecentSalesNearLowestPricePolicy
      DATE_THRESHOLD_FOR_RECENT_SALES = 30.days.ago
      MAXIMUM_RECENT_TRANSACTIONS_TO_CONSIDER = 10
      PERCENTAGE_THRESHOLD_FOR_NEAR_LOW_CRITERIA = 0.2 # 20 percent

      def self.should_badge?(listing:)
        new(listing: listing).should_badge?
      end

      def initialize(listing:)
        @listing = listing
      end

      def should_badge?
        listing_recently_selling_near_historic_low?
      end

      private

      attr_reader :listing

      def listing_recently_selling_near_historic_low?
        percent_from_lowest_price <= PERCENTAGE_THRESHOLD_FOR_NEAR_LOW_CRITERIA
      end

      def percent_from_lowest_price
        # if $90 current / $75 historic low = 1.2 - 1 = 0.2 percent
        (average_recent_price / listing.price_guide_bottom_price) - 1
      end

      def average_recent_price
        total_price_recent_sales / MAXIMUM_RECENT_TRANSACTIONS_TO_CONSIDER
      end

      def total_price_recent_sales
        recent_similar_transactions.sum do |transaction|
          transaction["price_final"]["amount"].to_f
        end.round(2)
      end

      def recent_similar_transactions
        listing.
          transactions.
          after_date(date: DATE_THRESHOLD_FOR_RECENT_SALES).
          with_similar_condition_to(condition: listing.condition).
          filtered_transactions.
          first(MAXIMUM_RECENT_TRANSACTIONS_TO_CONSIDER)
      end
    end
  end
end
