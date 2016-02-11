class DropBookmarkDate < ActiveRecord::Migration
  def change
    remove_column :bookmarks, :date
  end
end
