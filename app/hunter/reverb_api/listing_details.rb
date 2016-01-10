module Hunter
  module ReverbAPI
    class ListingDetails
      def self.details(listing:)
        new(listing: listing).details
      end

      def initialize(listing:)
        @listing = listing
      end

      def details
        ListingDetailsResult.new(response: response)
      end

      private

      attr_reader :listing

      def response
        @_response ||= Hunter::ReverbAPI::Client.get(endpoint: "listings/#{slug}")
      end

      def slug
        listing.details_url.split("/").last
      end
    end
  end
end
