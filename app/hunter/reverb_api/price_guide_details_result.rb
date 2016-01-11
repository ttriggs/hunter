module Hunter
  module ReverbAPI
    class PriceGuideDetailsResult
      def initialize(response:)
        @response = response
      end

      def total_transactions
        parsed_results["total"]
      end

      def transactions
        parsed_results["transactions"]
      end

      private

      def parsed_results
        @_parsed_results ||= JSON.parse(@response)
      end
    end
  end
end
