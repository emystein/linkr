# frozen_string_literal: true

class NotificationRendererMigration < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :type, :string, index: true
  end
end
