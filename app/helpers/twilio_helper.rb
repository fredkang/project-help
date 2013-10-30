module TwilioHelper

	def sendText(sender_id, receiver_id, text)

		sender = User.find(sender_id)
		receiver = User.find(receiver_id)

		message_text = "Project Help msg from " + sender.first_name + ": " + text

		if(message_text.length > 160)
			message_text = message_text[0, 157] + "..."
		end

		if receiver.phone_number
			# Get your Account Sid and Auth Token from twilio.com/user/account
			account_sid = 'AC868f92b622639d7aab5113502ee14f1b'
			auth_token = 'de58608bb2c23e0bcbb31a435decbd72'
			@client = Twilio::REST::Client.new account_sid, auth_token
			 
			message = @client.account.messages.create(:body => message_text,
			    :to => "+1"+receiver.phone_number,
			    :from => "+14086274495")
			puts message.to
		end
	end
end