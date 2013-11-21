class TopicsController < ApplicationController
  def search
  	search_term = params['search_term']
  	
  	respond_to do |format|
	  	format.html { redirect_to '/home/dashboard' }
	  	format.json { render json: {:search_term => search_term} }
	end
  end

  def show
  	@users
  	@posts
  end

	private
		# Never trust parameters from the scary internet, only allow the white list through.
	    def topic_params
	      params.require(:post).permit(:search_term)
	    end
	
end
