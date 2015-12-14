class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer  :saved_search_id
      t.string   :reverb_id
      t.string   :title
      t.string   :url
      t.string   :make
      t.string   :model
      t.datetime :date_created
      t.integer  :year
      t.string   :condition
      t.integer  :price_cents
      t.integer  :shipping_cents
      t.string   :shop
      t.boolean  :offers


      t.timestamps
    end

    add_index :listings, [:reverb_id, :saved_search_id], unique: true
  end
end
