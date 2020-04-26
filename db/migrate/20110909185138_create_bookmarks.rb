class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :location_id
      t.text :notes
      t.timestamps
      t.boolean :private, default: false
    end
  end
end
