module Hunter
  module ReverbAPI
    class PriceGuideTransactions
      MAXIMUM_TRANSACTIONS_TO_RETRIEVE = 40

      def initialize(listing:)
        @listing = listing
      end

      def transactions
        PriceGuideTransactionsResult.transactions(response: response)
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
        { per_page: MAXIMUM_TRANSACTIONS_TO_RETRIEVE }
      end
    end
  end
end