class SearchesController < ApplicationController
  def index
    @searches = Search.all
  end

  def new
    @search = Search.new
  end

  def edit
    @search = find_search
  end

  def create
    @search = Search.new(search_params)

    if @search.save
      redirect_to searches_path, notice: 'Search created successfully!'
    else
      render :new
    end
  end

  def update
    @search = find_search
    if @search.update(search_params)
      redirect_to @search, notice: 'Search was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @search = find_search
    @search.destroy
    redirect_to searches_path, notice: 'Search deleted.'
  end

  private

  def find_search
    @search = Search.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:query, :make, :min_price, :max_price)
  end
end
