class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :make
      t.string :query
      t.boolean :state
      t.integer :min_price, default: 0
      t.integer :max_price

      t.timestamps
    end

    add_index :searches, :query
  end
end
