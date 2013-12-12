class UserMailer < ActionMailer::Base
  default from: "Project Help <support@projecthelp.co>"

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

  # Notification email when someone comments on a post that this user created
  def comment_email(user, commenter, comment, post)
    @user = user
    @commenter = commenter
    @comment = comment

    if !post.title.blank?
      @str = post.title
      @str = @str.split[0...3].join(' ')
    else
      @str = post.text
      @str = @str.split[0...3].join(' ')
    end

    if post.postable_type == "User"
      @url = 'http://www.projecthelp.co/users/' + post.postable_id.to_s
    else
      @url = 'http://www.projecthelp.co/groups/' + post.postable_id.to_s
    end

    mail   :to    => user.email,
           :subject => @commenter.first_name + " responded to your post on \"" + @str + "...\""
  end

  # Notification email when someone thanks you for your post or comment
  def thank_email(user, thanker, item, item_type)
    # @user = user
    # @thanker = thanker
    # @item = item

    # Text and linkback URL of the email depends on if the thanked item was a post or a comment
    if item_type == "Post"

      if !item.title.blank?
        str = item.title
        str = str.split[0...3].join(' ')
      else
        str = item.text
        str = str.split[0...3].join(' ')
      end

      @str = "Your post on \"" + str + "...\" was helpful to " +thanker.first_name+ ". Thanks!"

      # URL to link them back depends on if the item was on a user or a group
      if item.postable_type == "User"
        @url = 'http://www.projecthelp.co/users/' + item.postable_id.to_s
      else
        @url = 'http://www.projecthelp.co/groups/' + item.postable_id.to_s
      end

    # Text and linkback URL of the email depends on if the thanked item was a post or a comment
    else
      str = item.text.split[0...3].join(' ')

      @str = "Your comment on \"" + str + "...\" was helpful to " +thanker.first_name+ ". Thanks!"
      
      # URL to link them back depends on if the item was on a user or a group
      post = Post.find(item.post_id)
      if post.postable_type == "User"
        @url = 'http://www.projecthelp.co/users/' + post.postable_id.to_s
      else
        @url = 'http://www.projecthelp.co/groups/' + post.postable_id.to_s
      end
    end

    mail   :to    => user.email,
           :subject => "Thanks for being helpful!"
  end

  # Daily digest email that is sent once per day when a user has a new post on her profile or there are new posts in any
  # of their groups
  def dailydigest_email(user)
    @user = user

    @profile_posts, @group_posts = Post.new_day_posts(@user)

    # @profile_posts is an array with posts. Add an element to the beginning of the array with a string 
    # declaring how many new posts the user has
    if @profile_posts.length==1
      string = "1 new post on your profile today" #. Answer or thank them! // www.projecthelp.co/users/" +user.id.to_s
      @profile_posts.unshift(string)
    elsif @profile_posts.length>1
      string = @profile_posts.length.to_s + " new posts on your profile today. Answer or thank them! // www.projecthelp.co/users/" +user.id.to_s
      @profile_posts.unshift(string)
    end

    subject = "New posts for you today"
    # @group_posts is an array with posts. Add an element to the beginning of the array with a string 
    # declaring how many new posts the user has
    @group_posts.each do |group_id, posts|
      if !posts[0].title.blank?
        subject = posts[0].title
      end

      if posts.length == 1
        string = "1 new post in " +Group.find(group_id).name+ " today" #. Answer or thank them! // www.projecthelp.co/groups/" +group_id.to_s
        posts.unshift(string)
      elsif posts.length > 1
        string = posts.length.to_s+ " new posts in " +Group.find(group_id).name+ " today. Answer or thank them! // www.projecthelp.co/groups/" +group_id.to_s
        posts.unshift(string)
      end

    end

    if (@profile_posts!=nil && @profile_posts.length>0) || (@group_posts!=nil && @group_posts.length>0)
      mail  :to       => user.email,
            :subject  => subject
    end
  end

  # Sends a link to reset the user's password
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password reset for Project Help"
  end
end
