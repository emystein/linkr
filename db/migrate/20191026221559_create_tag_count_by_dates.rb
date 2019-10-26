class CreateTagCountByDates < ActiveRecord::Migration[5.2]
  def change
    create_view :tag_count_by_dates
  end
end
