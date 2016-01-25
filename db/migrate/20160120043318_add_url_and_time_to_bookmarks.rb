class AddUrlAndTimeToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :url, :string
    add_column :bookmarks, :time, :string
  end
end
