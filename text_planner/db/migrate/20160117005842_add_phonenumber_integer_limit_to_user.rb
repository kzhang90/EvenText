class AddPhonenumberIntegerLimitToUser < ActiveRecord::Migration
  def change
    remove_column :users, :phone_number, :integer, limit: 8
  end
end
