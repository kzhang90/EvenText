class ChangeUsersColumnNameAndAddColumn < ActiveRecord::Migration
  def change
    rename_column :users, :title, :first_name
    add_column :users, :last_name, :string
  end
end
