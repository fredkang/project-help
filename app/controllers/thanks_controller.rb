class ThanksController < ApplicationController
	def create

		@new_thank = Thank.new(thank_params)

		if thank_params['thanked_type'] == "Post"
			thanked_item = Post.find(thank_params['thanked_id'])
			groupid = thanked_item.postable_id

		elsif thank_params['thanked_type'] == "Comment"
			thanked_item = Comment.find(thank_params['thanked_id'])
			groupid = Post.find(thanked_item.post_id).postable_id
		end

	  	respond_to do |format|

	  		if @new_thank.save
	  			thank_string = thanks_string(thanked_item.thanks)

	  			format.html { redirect_to '/groups/'+groupid.to_s}
	  			format.json { render json: {:thank_string => thank_string}}
	  		else
	  			format.html { redirect_to '/groups/'+groupid.to_s }
		  		format.json { render json: {:errors => @new_thank.errors} }
	  		end
		  	
	    end
  	end

	def destroy
		@thank = Thank.find(params[:id])

		if @thank.thanked_type == "Post"
			thanked_item = Post.find(thank_params['thanked_id'])
			groupid = thanked_item.postable_id

		elsif @thank.thanked_type == "Comment"
			thanked_item = Comment.find(thank_params['thanked_id'])
			groupid = Post.find(thanked_item.post_id).postable_id
		end

	    @thank.destroy

	    respond_to do |format|
	    	thank_string = thanks_string{thanked_item.thanks}
	    	
      		format.html { redirect_to "/groups/" +groupid.to_s }
      		format.json { render json: {:thank_string => thank_string} }
	    end
  end
	end

	private
		# Never trust parameters from the scary internet, only allow the white list through.
	    def thank_params
	      params.require(:thank).permit(:thanker_id, :thanked_id, :thanked_type, :thanked_uid)
	    end
end
