class AddColumnToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :body, :text
  end
end
