class ChangeBookmarkAndReminderDatabaseColumnToDateTime < ActiveRecord::Migration
  def change
    remove_column :reminders, :time
  end
end
