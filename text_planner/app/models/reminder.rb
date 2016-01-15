class Reminder < ActiveRecord::Base
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
  # may need to make changes here
end
