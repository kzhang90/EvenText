class Reminder < ActiveRecord::Base
  validates :title, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
  # may need to make changes here
  belongs_to :user

  after_create :send_text_message

  @@SEND_TEXT_MESSAGE_TIME = 60.minutes

  def send_text_message
    # each bookmark will have an option to send_text_message_path
    number_to_send_to = "+"+user.phone_number.to_s

    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token
    @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "get information into this body"

      )
  end

  def when_to_run
    time - @@SEND_TEXT_MESSAGE_TIME
  end
  # if you ad validations to your models you get free error reporting with the session's flash obj.

  # look up each future reminder, add it to jobs table, check whether it is within the @@send_text_message_time interval
  handle_asynchronously :send_text_message, :run_at => Proc.new { |i| i.when_to_run }
end
