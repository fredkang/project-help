desc "This task is called by the Heroku scheduler add-on"
task :send_daily_digest_emails => :environment do
  puts "Send daily digest emails..."

  User.all.to_a.each do |user|
  	UserMailer.dailydigest_email(user).deliver
  end
  
  puts "done sending daily digest emails."
end

