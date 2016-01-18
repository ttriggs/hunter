module Hunter
  module ReverbAPI
    class Client
      include HTTParty
      REVERB_API_BASE_URL = 'https://reverb.com/api/'

      def self.search(endpoint:, query:)
        new(endpoint: endpoint, query: query).search
      end

      def self.get(endpoint:)
        new(endpoint: endpoint).get
      end

      def initialize(endpoint:, query: "")
        @endpoint = endpoint
        @query = query
      end

      def search
        HTTParty.get(url, query: query)
      end

      def get
        HTTParty.get(url)
      end

      private

      attr_reader :endpoint, :query

      def url
        "#{REVERB_API_BASE_URL}/#{endpoint}"
      end
    end
  end
end
