module Hunter
  module ReverbAPI
    class Client
      include HTTParty
      REVERB_API_BASE_URL = 'https://reverb.com/api/'

      def self.search(endpoint:, query:)
        new(endpoint: endpoint, query: query).search
      end

      def initialize(endpoint:, query: "")
        @endpoint = endpoint
        @query = query
      end

      def search
        HTTParty.get(search_url, query: query)
      end

      private

      attr_reader :endpoint, :query

      def search_url
        "#{REVERB_API_BASE_URL}/#{endpoint}"
      end
    end
  end
end
