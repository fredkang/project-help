class UserMailer < ActionMailer::Base
  default from: "Project Help <support@projecthelp.com>"

  def welcome_email(user)
  	@user = user

  	mail :to		=> user.email,
  		 :subject	=> "Welcome to Project Help!"
  end

  def message_email(user, sender, message, convoID)
  	@user = user
  	@message = message
  	@sender = sender
  	@url = 'http://localhost:3000/inbox/' + convoID.to_s

  	mail :to		=> user.email,
  		 :subject	=> "New message from " + @sender.first_name
  end

  def group_notification_email
  end
end
