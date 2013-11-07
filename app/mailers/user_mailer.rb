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
  	@url = 'http://www.projecthelp.co/inbox/' + convoID.to_s

  	mail   :to		=> user.email,
           :subject	=> "New message from " + @sender.first_name
  end

  def dailydigest_email(user)
    @user = user

    posts = Post.new_group_posts(@user)

    @profileposts
    @groupposts = {}

    posts.each do |id, count|
      if id == 0
        if count == 1
          @profileposts = count.to_s + " new post on your profile today. Someone is thanking you or asking you a question."
        else
          @profileposts = count.to_s + " new posts on your profile today. People are thanking you and asking you a questions."
        end

        @profileposts = @profileposts + " //  wwww.projecthelp.co/users/" +user.id.to_s
      else
        if count == 1
          @groupposts[id] = count.to_s + " new post in " + Group.find(id).name + ". Someone is asking or answering a question."
        else
          @groupposts[id] = count.to_s + " new posts in " + Group.find(id).name + ". People are asking and answering questions."
        end

        @groupposts[id] = @groupposts[id] + " //  www.projecthelp.co/groups/" +id.to_s
      end
    end

    if @profileposts != nil || @groupposts.length>0
      mail  :to       => user.email,
            :subject  => "New posts for you today"
    end
  end
end
