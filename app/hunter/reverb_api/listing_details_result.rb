module Hunter
  module ReverbAPI
    class ListingDetailsResult
      def initialize(response:)
        @response = response
      end

      def payment_methods
        parsed_results["accepted_payment_methods"]
      end

      private

      def parsed_results
        @_parsed_results ||= JSON.parse(@response)
      end
    end
  end
end
