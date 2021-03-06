class Reminder < ActiveRecord::Base
  validates :title, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
  belongs_to :user

  after_create :send_text_message

  # users will get a reminder 30 minutes before their event
  @@SEND_TEXT_MESSAGE_TIME = 30.minutes

  def send_text_message
    @twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
    @twilio_client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    # %k: 24hr time, %M: minute, %p: AM/PM, %b: e.g. "Jan", %d: zero padded day of the month e.g. "01"
    numba = "+1"+self.phone_number
    time_str = ((self.time).localtime).strftime("%k:%M%p on %b. %d")
    body = "#{self.title} at #{time_str}."
    message = @twilio_client.account.messages.create(
      :from => @twilio_phone_number,
      :to => numba,
      :body => body,
    )
  end

  def when_to_run
    time - @@SEND_TEXT_MESSAGE_TIME
  end

  handle_asynchronously :send_text_message, :run_at => Proc.new { |i| i.when_to_run }
end


