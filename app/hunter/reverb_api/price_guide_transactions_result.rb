module Hunter
  module ReverbAPI
    class PriceGuideTransactionsResult
      def initialize(response:, filters: [])
        @response = response
        @filters = Array(filters)
      end

      def total_transactions
        parsed_results["total"]
      end

      def transactions
        filtered_transactions
      end

      def after_date(date:)
        filters << lambda { |transaction| transaction["date"] > date }

        self
      end

      def with_similar_condition_to(condition:)
        condition_filter = lambda do |transaction|
          Hunter::SimilarConditionComparator.similar?(transaction["condition"], condition)
        end
        filters << condition_filter

        self
      end

      def filtered_transactions
        return all_transactions if filters.empty?

        all_transactions.select do |transaction|
          filters.all? do |filter_lambda|
            filter_lambda.call(transaction)
          end
        end
      end

      private

      attr_reader :filters

      def all_transactions
        parsed_results["transactions"]
      end

      def parsed_results
        @_parsed_results ||= JSON.parse(@response)
      end
    end
  end
end
