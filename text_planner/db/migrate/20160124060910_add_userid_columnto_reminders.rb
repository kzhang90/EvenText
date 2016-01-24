class AddUseridColumntoReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :user_id, :integer
  end
end
