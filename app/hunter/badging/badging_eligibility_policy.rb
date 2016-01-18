module Hunter
  module Badging
    # listings not deemed badgeable are filterd out of
    # in search results
    class BadgingEligibilityPolicy
      BAD_CONDITIONS = ['Poor', 'Non Functioning', 'Fair']

      def self.badgeable?(listing:)
        new(listing: listing).badgeable?
      end

      def initialize(listing:)
        @listing = listing
      end

      def badgeable?
        in_acceptable_condition? &&
          @listing.ships_to_us?
      end

      private

      def in_acceptable_condition?
        !BAD_CONDITIONS.include?(@listing.condition)
      end
    end
  end
end
