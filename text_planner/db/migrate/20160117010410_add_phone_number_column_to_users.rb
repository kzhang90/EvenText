class AddPhoneNumberColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :integer, limit: 8
  end
end
