class ChangeReminderTimeToString < ActiveRecord::Migration
  def change
    change_column :reminders, :time, :string
  end
end
