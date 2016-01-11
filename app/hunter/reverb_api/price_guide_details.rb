module Hunter
  module ReverbAPI
    class PriceGuideDetails
      TRANSACTIONS_PER_PAGE = 40

      def self.details(listing:)
        new(listing: listing).details
      end

      def initialize(listing:)
        @listing = listing
      end

      def details
        PriceGuideDetailsResult.new(response: response)
      end

      private

      attr_reader :listing

      def response
        @_response ||= Hunter::ReverbAPI::Client.search(endpoint: "priceguide/#{price_guide_id}/transactions", query: query_options)
      end

      def price_guide_id
        listing.price_guide_synopsis["_links"]["self"]["href"].split("/").last
      end

      def query_options
        { per_page: TRANSACTIONS_PER_PAGE }
      end
    end
  end
end
