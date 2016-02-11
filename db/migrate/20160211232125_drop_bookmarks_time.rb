class DropBookmarksTime < ActiveRecord::Migration
  def change
    remove_column :bookmarks, :time
  end
end
