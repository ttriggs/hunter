class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.integer :badge_type_id
      t.integer :listing_id

      t.timestamps
    end

    add_index :badges, [:badge_type_id, :listing_id], unique: true
  end
end
