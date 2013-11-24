class TopicsController < ApplicationController
  def search
  	search_term = params['search_term'].downcase

  	# Create an empty array to store the search results. Results will be returned
  	# as an array of Topics that match the search_term
  	search_result = []

  	# Scan through every topic and check the search term against it
  	topics = Topic.all.to_a
  	topics.each do |topic|

  		# Check if the search_term matches with the topic name
  		topic_name_match = !topic.name.downcase.match(search_term).nil?
  		
  		# Check if the search_term matches with any of helpoffers associated with
  		# this topic. Have to grab all of the helpoffers referencing this topic 
  		# first and check the search-term agains it
  		help_offer_match = false
  		helpoffers = topic.helpoffers.all.to_a

  		helpoffers.each do |helpoffer|

  			# Check the search term against both the title and the description
  			if helpoffer.title.downcase.match(search_term) || helpoffer.description.downcase.match(search_term)
  				help_offer_match = true
  			end
  		end

  		if topic_name_match || help_offer_match
  			search_result.push(topic)
  		end
  	end
  	
  	respond_to do |format|
	  	format.html { redirect_to '/home/dashboard' }
	  	format.json { render json: {:results => search_result} }
	end
  end

  def show
    @topic = Topic.find(params[:id])
  	@users = @topic.users.all.to_a
    @posts = []

    groups = current_user.groups.all.to_a

    groups.each do |group|
      topic = "%" + @topic.name + "%"
      posts = group.posts.where("text like ?", topic).to_a
      @posts = @posts + posts
    end

    @posts = @posts.sort {|a,b| b.created_at <=> a.created_at} 

    # all_posts.each do |post|
    #   if @topic.name.downcase.match(post.text.downcase)
    #     @posts.push(post)
    #   end
    # end
  end

	private
		# Never trust parameters from the scary internet, only allow the white list through.
	    def topic_params
	      params.require(:post).permit(:search_term)
	    end
	
end
