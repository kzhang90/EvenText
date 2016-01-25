class ChangeRemindersColumnName < ActiveRecord::Migration
  def change
    rename_column :reminders, :name, :title
  end
end
