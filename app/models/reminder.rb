class Reminder < ActiveRecord::Base
  validates :title, presence: true
  validates :phone_number, presence: true
  validates :time, presence: true
  belongs_to :user

  after_create :send_text_message

  @@SEND_TEXT_MESSAGE_TIME = 60.minutes

  def send_text_message
    @twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']
    @twilio_client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @twilio_client.account.sms.messages.create(
      :from => @twilio_phone_number,
      :to => self.phone_number,
      :body => body,
      )
  end

  def when_to_run
    time - @@SEND_TEXT_MESSAGE_TIME
  end

  handle_asynchronously :send_text_message, :run_at => Proc.new { |i| i.when_to_run }
end

# heroku config:set TWILIO_ACCOUNT_SID=hkjfdshfkjh3kjrh3kjwhk3h32
