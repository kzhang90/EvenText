class Reminder < ActiveRecord::Base
  validates :title, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
  belongs_to :user

  after_create :send_text_message

  @@SEND_TEXT_MESSAGE_TIME = 5.minutes

  def send_text_message
    @twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
    @twilio_client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    # %k: 24hr time, %M: minute, %p: AM/PM, %b: e.g. "Jan", %d: zero padded day of the month e.g. "01"
    numba = "+1"+self.phone_number
    time_str = ((self.time).localtime).strftime("%k:%M%p on %b. %d")
    body = "Hi. Just a reminder that #{self.title} is coming up at #{time_str}."
    message = @twilio_client.account.sms.messages.create(
      :from => @twilio_phone_number,
      :to => numba,
      :body => body,
      )
    puts message
  end
# make everything time
  def when_to_run
    # parse 2016-02-14 17:30:00 UTC - int seconds
    time - @@SEND_TEXT_MESSAGE_TIME
  end

  handle_asynchronously :send_text_message, :run_at => Proc.new { |i| i.when_to_run }
end


