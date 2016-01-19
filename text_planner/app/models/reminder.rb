class Reminder < ActiveRecord::Base
  validates :title, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
  # may need to make changes here
  belongs_to :user
end
