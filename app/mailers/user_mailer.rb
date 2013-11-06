class UserMailer < ActionMailer::Base
  default from: 'support@projecthelp.com'
  
  def test_email
    mail :subject => "Mandrill rides the Rails!",
         :to      => "fredkang@gmail.com",
         :from    => "test@projecthelp.com"
  end

  def welcome_email(user)
  	@user = user

  	mail :to		=> user.email,
  		 :subject	=> "Welcome to Project Help!"
  end

  def message_email
  end

  def group_notification_email
  end
end
