class ChangeBookmarksColumnName < ActiveRecord::Migration
  def change
    rename_column :bookmarks, :name, :title
  end
end
