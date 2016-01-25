class Reminder < ActiveRecord::Base
  validates :title, presence: true
  validates :time, presence: true
  belongs_to :user

  after_create :send_text_message

  # change this when possible
  @@SEND_TEXT_MESSAGE_TIME = 1.minutes

  def send_text_message

    number_to_send_to = "+"+@user.phone_number.to_s
    body = "testing"

    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => @user.bookmark.description
      )
    # find current user in the controller
  end

  def when_to_run
    time - @@SEND_TEXT_MESSAGE_TIME
  end

  handle_asynchronously :send_text_message, :run_at => Proc.new { |i| i.when_to_run }
end
