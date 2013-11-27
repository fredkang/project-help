class UserMailer < ActionMailer::Base
  default from: "Project Help <support@projecthelp.com>"

  # Sent when a new user registers
  def welcome_email(user)
  	@user = user

  	mail :to		=> user.email,
  		 :subject	=> "Welcome to Project Help!"
  end

  # Notification email when a user receives a message
  def message_email(user, sender, message, convoID)
  	@user = user
  	@message = message
  	@sender = sender
  	@url = 'http://www.projecthelp.co/inbox/' + convoID.to_s

  	mail   :to		=> user.email,
           :subject	=> "New message from " + @sender.first_name
  end

  # Daily digest email that is sent once per day when a user has a new post on her profile or there are new posts in any
  # of their groups
  def dailydigest_email(user)
    @user = user

    @profile_posts, @group_posts = Post.new_day_posts(@user)

    # @profile_posts is an array with posts. Add an element to the beginning of the array with a string 
    # declaring how many new posts the user has
    if @profile_posts.length==1
      string = "1 new post on your profile today. Answer or thank them! // www.projecthelp.co/users/" +user.id.to_s
      @profile_posts.unshift(string)
    elsif @profile_posts.length>1
      string = @profile_posts.length.to_s + " new posts on your profile today. Answer or thank them! // www.projecthelp.co/users/" +user.id.to_s
      @profile_posts.unshift(string)
    end

    # @group_posts is an array with posts. Add an element to the beginning of the array with a string 
    # declaring how many new posts the user has
    @group_posts.each do |group_id, posts|
      if posts.length == 1
        string = "1 new post in " +Group.find(group_id).name+ " today. Answer or thank them! // www.projecthelp.co/groups/" +group_id.to_s
        posts.unshift(string)
      elsif posts.length > 1
        string = posts.length.to_s+ " new posts in " +Group.find(group_id).name+ " today. Answer or thank them! // www.projecthelp.co/groups/" +group_id.to_s
        posts.unshift(string)
      end

    end

    if (@profile_posts!=nil && @profile_posts.length>0) || (@group_posts!=nil && @group_posts.length>0)
      mail  :to       => user.email,
            :subject  => "New posts for you today"
    end
  end

  # Sends a link to reset the user's password
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password reset for Project Help"
  end
end
