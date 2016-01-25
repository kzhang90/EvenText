class ChangeBookmarksDataTypeForUrlAndDescription < ActiveRecord::Migration
  def change
    change_column :bookmarks, :description, :text
    change_column :bookmarks, :url, :text
  end
end
