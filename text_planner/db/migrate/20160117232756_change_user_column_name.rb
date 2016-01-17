class ChangeUserColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :name, :title
  end
end
