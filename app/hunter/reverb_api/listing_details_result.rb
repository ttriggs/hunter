module Hunter
  module Reverb_API
    class ListingDetailsResult
      def self.parsed(response:)
        new(response: response).parsed_results
      end

      def initialize(response:)
        @response = response
      end

      def payment_methods
        parsed_results["accepted_payment_methods"] # FIXME
      end

      def parsed_results
        @_parsed_results ||= JSON.parse(@response)
      end
    end
  end
end
