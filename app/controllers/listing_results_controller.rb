class ListingResultsController < ApplicationController

  def show
    @saved_search = find_saved_search
    search_results = Hunter::SearchListings.search(saved_search: @saved_search)
    @search_results = ::ListingsSearchResultsView.new(search_results: search_results)
  end

  private

  def find_saved_search
    SavedSearch.find(params[:id])
  end
end
