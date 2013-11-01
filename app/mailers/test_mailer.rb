class TestMailer < ActionMailer::Base
  def test_email
    mail :subject => "Mandrill rides the Rails!",
         :to      => "mark@bercow.com",
         :from    => "test@projecthelp.com"
  end
end