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

      def price_guide_top_price
        estimated_value_hash["top_price"]
      end

      def price_guide_bottom_price
        estimated_value_hash["bottom_price"]
      end

      def estimated_value_hash
        price_guide_synopsis["estimated_value"]
      end

      private

      def parsed_results
        @_parsed_results ||= JSON.parse(@response)
      end
    end
  end
end
