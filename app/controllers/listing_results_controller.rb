class ListingResultsController < ApplicationController

  def show
    saved_search = find_saved_search
    @search_results_view = ListingsSearchResultsView.new(saved_search: saved_search)
  end

  def update
    saved_search = find_saved_search
    Hunter::UpdateSavedSearchResults.update(saved_search: saved_search)
    @search_results_view = ListingsSearchResultsView.new(saved_search: saved_search)

    render :show
  end

  private

  def find_saved_search
    SavedSearch.find(params[:id])
  end
end
