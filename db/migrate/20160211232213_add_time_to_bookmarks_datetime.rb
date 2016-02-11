class AddTimeToBookmarksDatetime < ActiveRecord::Migration
  def change
    add_column :bookmarks, :time, :datetime
    add_column :reminders, :time, :datetime
  end
end
