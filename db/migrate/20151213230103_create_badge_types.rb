class CreateBadgeTypes < ActiveRecord::Migration
  def change
    create_table :badge_types do |t|
      t.string  :name
      t.text    :description

      t.timestamps
    end
  end
end
