class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :query
      t.string :make
      t.integer :min_price, default: 0
      t.integer :max_price

      t.timestamps
    end

    add_index :searches, :query
  end
end
