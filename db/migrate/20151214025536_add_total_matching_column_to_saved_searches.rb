class AddTotalMatchingColumnToSavedSearches < ActiveRecord::Migration
  def change
    add_column :saved_searches, :total_matching_listings, :integer
  end
end
