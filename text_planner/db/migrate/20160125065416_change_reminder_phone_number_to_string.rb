class ChangeReminderPhoneNumberToString < ActiveRecord::Migration
  def change
    change_column :reminders, :phone_number, :string
  end
end
