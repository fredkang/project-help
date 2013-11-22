class HomeController < ApplicationController
  before_action :deny_access, only: [:dashboard]

  def dashboard

    # ----- Store all of the users that are in current_user's network in @users -------------------

  	# First grab all of the users
    all_users = User.all.to_a.sort_by { |obj| obj.first_name }

    @users = []

    # Go through each user and check if it is any of the same groups as the current user
    # Store users in current_user's network in @user
    all_users.each do |user|
      if (user.groups.to_a & current_user.groups.to_a).length>0
        @users.push(user)
      end
    end

    # ------ Done getting all users in the network -------------------------------------------------


    # ----- Grab all groups the user is in ---------------------------------------------------------
    @groups = current_user.groups.all.to_a
    @group_users = []
    @group_topics = []
    @group_helpers = []
    @group_posts = []

    @groups.each_with_index do |group, i|
      @group_users[i] = group.users.all.to_a
      @group_topics[i] = group.topics.all.to_a

      # Get the 5 people with the most helpoffers in this group. Reference the @group_users array
      # above which already has the users in this group
      @group_helpers[i] = @group_users[i].sort {|a,b| b.helpoffers.count <=> a.helpoffers.count}
      if @group_helpers[i].length>5
        @group_helpers[i] = @group_helpers[i].slice(0..4)
      end

      # Get the last 2 posts created in this group and store in @group_posts
      @group_posts[i] = group.posts.all.to_a.sort {|a,b| b.created_at <=> a.created_at }
      @group_posts[i] = @group_posts[i].slice(0..1)
    end
    # ----- Done grabbing all groups the user is in ------------------------------------------------
    

    # ------ Get all of the topics available to current_user, deliver in both all and featured topics

    # Store all of the topics of available in the current_user's network - all of the topics
    # that @users have listed - in @all_topics. Do this by looping through @group_topics which
    # already contain all of the topics, just not in the format that we want
    @all_topics = []

    # Since we already have all of the topics in all of the groups the current_user belongs to
    # in @group_topics, a 2D array, we need to loop through it to create a new array containing
    # all topics in a 1D array with no repeats
    @group_topics.each do |topics|
      topics.each do |topic|
        # Only add the topic if it isn't already listed in the array
        if !@all_topics.include?(topic)
          @all_topics.push(topic)
        end
      end
    end

    # Sort @all_topics alphabetically
    @all_topics = @all_topics.sort_by { |obj| obj.name}

    # Create a @featured_topics array out of the 10 most popular topics from @all_topics
    # if there are more than 10 topics. Otherwise, @featured_topics = @all_topics
    if @all_topics.length>20
	  	@featured_topics = @all_topics.sort { |a,b| (b.click_count + b.helpoffers_count)<=>(a.click_count + a.helpoffers_count)}
	  	@featured_topics = @featured_topics.slice(0..19)
  	else
  		@featured_topics = @all_topics
  	end

    # ----- Done getting all of the topics available to current_user -------------------------------



  end # End Dashboard function

end
