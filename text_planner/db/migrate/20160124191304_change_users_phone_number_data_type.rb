class ChangeUsersPhoneNumberDataType < ActiveRecord::Migration
  def change
    change_column :users, :phone_number, :bigint
  end
end
