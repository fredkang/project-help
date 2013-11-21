class HomeController < ApplicationController
  def dashboard

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

    # Store all of the topics of these people have listed - all of the topics
    # that are available to this user - in @all_topics. Do this by looping
    # through @users and adding all of their topics
    @all_topics = []

    @users.each do |user|
    	# Grab all of the topics for that user and add them one by one
		user.topics.to_a.each do |topic|
	      	# Only add the topic if it isn't already listed in the array
	      	if !@all_topics.include?(topic)
	        	@all_topics.push(topic)
	        end
		end
    end

    @all_topics = @all_topics.sort_by { |obj| obj.name}

    # Create a @featured_topics array out of the 10 most popular topics from @all_topics
    # if there are more than 10 topics. Otherwise, @featured_topics = @all_topics
    if @all_topics.length>20
	  	@featured_topics = @all_topics.sort { |a,b| (b.click_count + b.helpoffers_count)<=>(a.click_count + a.helpoffers_count)}
	  	@featured_topics = @featured_topics.slice(0..19)
	else
		@feature_topics = @all_topics
	end

  end
end
