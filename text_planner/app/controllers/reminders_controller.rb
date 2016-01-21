class RemindersController < ApplicationController
  
  def index
  end

  def send_text_message
    # each bookmark will have an option to send_text_message_path
    number_to_send_to = "+"+current_user.phone_number.to_s

    twilio_sid = ENV['TWILIO_ACCOUNT_SID']
    twilio_token = ENV['TWILIO_AUTH_TOKEN']
    twilio_phone_number = ENV['TWILIO_PHONE_NUMBER']

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "#{title} at #{location} is happening at #{time}. Info: #{description}"

      )
  end

end
