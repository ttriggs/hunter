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
        Hunter::ReverbAPI::ListingDetailsResult.parsed(response: response)
      end

      private

      attr_reader :listing

      def response
        @_response ||= Hunter::ReverbAPI::Client.get(endpoint: listing.details_url)
      end
    end
  end
end
