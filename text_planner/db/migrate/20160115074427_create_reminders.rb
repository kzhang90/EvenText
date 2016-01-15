class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.integer :phone_number
      t.integer :time

      t.timestamps null: false
    end
  end
end
