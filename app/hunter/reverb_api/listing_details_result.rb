module Hunter
  module ReverbAPI
    class ListingDetailsResult
      def initialize(response:)
        @response = response
      end

      def payment_methods
        parsed_results["accepted_payment_methods"]
      end

      def price_guide_synopsis
        parsed_results["_embedded"]["price_guide"]
      end

      def price_guide_web_url
        price_guide_synopsis["_links"]["web"]["href"]
      end

      private

      def parsed_results
        @_parsed_results ||= JSON.parse(@response)
      end
    end
  end
end
