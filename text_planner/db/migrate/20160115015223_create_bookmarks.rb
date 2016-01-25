class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :name
      t.string :image
      t.string :description
      t.string :location
      t.datetime :date
      t.references :user

      t.timestamps null: false
    end
  end
end
