module Hunter
  module Badging
    class BadgeListings
      def self.add_badges(listings:)
        new(listings: listings).add_badges
      end

      def initialize(listings:)
        @listings = listings
      end

      def add_badges
        add_generic_badges
        add_low_price_group_badges
      end

      private
      attr_reader :listings

      def add_generic_badges
        Hunter::Badging::BadgingKlasses::GENERIC_BADGERS.each do |badging_klass|
          badging_klass.badge_listings(listings: listings)
        end
      end

      def add_low_price_group_badges
        Hunter::Badging::BadgingKlasses::BADGERS_FOR_LOW_PRICE_GROUP.each do |badging_klass|
          badging_klass.badge_listings(listings: low_price_group_or_cheapest_listings)
        end
      end

      def low_price_group_or_cheapest_listings
        if low_price_group_listings.present?
          low_price_group_listings
        else
          listings.first(3)
        end
      end

      def low_price_group_listings
        listings.select do |listing|
          listing.badges.include?(IdealPriceMargin::BADGE)
        end
      end
    end
  end
end
