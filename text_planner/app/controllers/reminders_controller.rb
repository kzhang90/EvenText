class RemindersController < ApplicationController
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
end
