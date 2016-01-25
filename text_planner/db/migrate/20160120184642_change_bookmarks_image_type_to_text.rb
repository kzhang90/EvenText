class ChangeBookmarksImageTypeToText < ActiveRecord::Migration
  def change
    change_column :bookmarks, :image, :text
  end
end
