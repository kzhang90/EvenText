class ChangeBookmarkAndReminderDatabaseColumnToDateTime < ActiveRecord::Migration
  def change
    change_column :reminders, :time, :datetime
    change_column :bookmarks, :time, :datetime
    remove_column :bookmarks, :date
  end
end
