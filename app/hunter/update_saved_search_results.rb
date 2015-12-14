module Hunter
  class UpdateSavedSearchResults

    def self.update(saved_search:)
      new(saved_search: saved_search).update
    end

    def initialize(saved_search:)
      @saved_search = saved_search
    end


    def update
      destroy_saved_search_listings

      saved_search.update_attributes(total_matching_listings: search_results[:total])

      Hunter::CreateListingsFromSearchResults.create(search_results: search_results,
                                                     saved_search: saved_search)
    end

    private

    attr_reader :saved_search

    def destroy_saved_search_listings
      saved_search.listings.destroy_all
    end

    def search_results
      @_search_results ||= Hunter::SearchListings.search(saved_search: saved_search)
    end
  end
end
