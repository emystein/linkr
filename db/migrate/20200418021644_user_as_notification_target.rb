class UserAsNotificationTarget < ActiveRecord::Migration[6.0]
  def change
    # A Hashie::Mash object that stores all the settings of a notification target.
    add_column :users, :settings, :text

    # A string that describes a notification-relevant state of a notification target.
    add_column :users, :status, :string
  end
end
