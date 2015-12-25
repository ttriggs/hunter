module Hunter
  class SearchResult < OpenStruct
    def self.parse(raw_search_result:)
      new(JSON.parse(raw_search_result))
    end
  end
end
