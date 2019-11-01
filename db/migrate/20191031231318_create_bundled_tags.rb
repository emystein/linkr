class CreateBundledTags < ActiveRecord::Migration[6.0]
  def change
    create_table :bundled_tags do |t|
      t.belongs_to :tag_bundle
      t.belongs_to :tag
      t.timestamps
    end
  end
end
