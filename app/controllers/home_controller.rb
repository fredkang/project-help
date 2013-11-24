class HomeController < ApplicationController
  before_action :deny_access, only: [:dashboard]

  def dashboard

    # ----- Grab all groups the user is in ---------------------------------------------------------
    @groups = current_user.groups.all.to_a
    @group_users = []
    @group_topics = []
    @group_helpers = []
    @group_posts = []
    @users = []
    @all_topics = []

    @groups.each_with_index do |group, i|
      @group_users[i] = group.users.includes(:helpoffers).all.to_a
      @group_topics[i] = group.topics.all.to_a

      # Store all of the users in each of the current_users' groups into @users. This is current_user's
      # network of users
      @users = @users|@group_users[i]

      # Store all of the topics in each of the current_users' groups into @all_topics. This array
      # contains all of the help topics available to current_user
      @all_topics = @all_topics|@group_topics[i]

      # Get the 5 people with the most helpoffers in this group. Reference the @group_users array
      # above which already has the users in this group
      @group_helpers[i] = @group_users[i].sort {|a,b| b.helpoffers.count <=> a.helpoffers.count}
      if @group_helpers[i].length>5
        @group_helpers[i] = @group_helpers[i].slice(0..2)
      end

      # Get the last 2 posts created in this group and store in @group_posts
      @group_posts[i] = group.posts.all.to_a.sort {|a,b| b.created_at <=> a.created_at }
      @group_posts[i] = @group_posts[i].slice(0..2)
    end
    # ----- Done grabbing all groups the user is in ------------------------------------------------
    

    # ------ Break up all_topics into a featured_topics subset -------------------------------------

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

    # ----- Done getting featured_topics -------------------------------



  end # End Dashboard function

end
