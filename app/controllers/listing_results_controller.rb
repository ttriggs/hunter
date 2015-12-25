class ListingResultsController < ApplicationController

  def show
    saved_search = find_saved_search
    badged_listings = Hunter::ListingsFromSearchResults.create_listings(saved_search: saved_search)
    @search_results_view = ListingsSearchResultsView.new(saved_search: saved_search,
                                                         badged_listings: badged_listings)

  end

  private

  def find_saved_search
    SavedSearch.find(params[:id])
  end
end
