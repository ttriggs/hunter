class ListingResultsController < ApplicationController

  def show
    saved_search = find_saved_search
    search_results = Hunter::RetrieveListingsForSavedSearch.retrieve_listings(saved_search: saved_search)
    @search_results_view = ListingsSearchResultsView.new(saved_search: saved_search,
                                                         search_results: search_results)
  end

  private

  def find_saved_search
    SavedSearch.find(params[:id])
  end
end
