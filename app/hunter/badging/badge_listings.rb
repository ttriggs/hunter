require_relative 'badging_klasses'

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
        @listings.tap do |listings|
          Hunter::Badging::BadgingKlasses::ALL.each do |badging_klass|
            badging_klass.badge_listings(listings: listings)
          end
        end
      end
    end
  end
end
