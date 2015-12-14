class CreateListingPhotos < ActiveRecord::Migration
  def change
    create_table :listing_photos do |t|
      t.integer :listing_id
      t.integer :photo_id

      t.timestamps
    end

    add_index :listing_photos, [:listing_id, :photo_id], unique: true
  end
end
