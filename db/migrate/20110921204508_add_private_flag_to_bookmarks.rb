class AddPrivateFlagToBookmarks < ActiveRecord::Migration[5.1]
  def change
    add_column :bookmarks, :private, :boolean, :default => false
  end
end
