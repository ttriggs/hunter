class SavedSearchesController < ApplicationController
  def index
    @saved_searches = SavedSearch.all
  end

  def new
    @saved_search = SavedSearch.new
  end

  def show
    redirect_to saved_searches_path
  end

  def edit
    @saved_search = find_saved_search
  end

  def create
    @saved_search = SavedSearch.new(saved_search_params)

    if @saved_search.save
      redirect_to saved_searches_path, notice: 'Saved Search created successfully!'
    else
      render :new
    end
  end

  def update
    @saved_search = find_saved_search
    if @saved_search.update(saved_search_params)
      redirect_to @saved_search, notice: 'Saved Search was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @saved_search = find_saved_search
    @saved_search.destroy
    redirect_to saved_searches_path, notice: 'Saved Search deleted.'
  end

  private

  def find_saved_search
    SavedSearch.find(params[:id])
  end

  def saved_search_params
    params.require(:saved_search).permit(:query, :make, :min_price, :max_price)
  end
end
