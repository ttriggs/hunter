class CreateSavedSearches < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :query
      t.string :make
      t.integer :min_price, default: 0
      t.integer :max_price

      t.timestamps
    end

    add_index :saved_searches, :query
  end
end
