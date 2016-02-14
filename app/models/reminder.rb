class Reminder < ActiveRecord::Base
  validates :title, presence: true
  # below necessary? if can access current user phone number
  # validate phone number length is ten
  validates :phone_number, presence: true
  validates :time, presence: true
  belongs_to :user

  after_create :send_text_message

  @@SEND_TEXT_MESSAGE_TIME = 5.minutes

  # can I access current user in here now?
  # need to be able to update phone number for this to work
  # instance method below
  def send_text_message
    # @ means THIS OBJECT's twilio phone number etc
    @twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
    @twilio_client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    # %k: 24hr time, %M: minute, %p: AM/PM, %b: e.g. "Jan", %d: zero padded day of the month e.g. "01"
    numba = "+1"+self.phone_number
    time_str = ((self.time).localtime).strftime("%k:%M%p on %b. %d")
    body = "Hi #{current_user.first_name}. Just a reminder that #{self.title} is coming up at #{time_str}."
    @twilio_client.account.sms.messages.create(
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


