class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :url
      t.string :title
      t.integer :bookmark_id

      t.timestamps
    end
  end
end
