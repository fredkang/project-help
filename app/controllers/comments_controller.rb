class CommentsController < ApplicationController
	def create
		@comment = Comment.new(comment_params)
		post = Post.find(@comment.post_id)

		# Check if the post that this comment belongs to is on a User or a Post, so the redirect knows where to redirect to 
		if(post.postable_type == "User")
			postable_path = "users"
		else
			postable_path = "groups"
		end

		respond_to do |format|

			if @comment.save

				if @comment.post.postable_type == "Group"
					users = Group.find(@comment.post.postable_id).users.all

					users.each do |user|
					  Notification.new(:notifiable_id=>@comment.post.postable_id, :notifiable_type=>"Group", :user_id=>user.id).save
					end
				else
					Notification.new(:notifiable_id=>@comment.post.postable_id, :notifiable_type=>"User", :user_id=>@comment.post.postable_id).save
				end

				@user = User.find(@comment.user_id)

				format.html { redirect_to '/'+postable_path+'/'+post.postable_id.to_s } #@user, notice: 'User was successfully created.' }
				# format.json { render action: postable_path+'#show', status: :created, location: @post }
				# format.json { render json: {:comment=>@comment, :user=>User.find(@comment.user_id)}, status: :created, location: post}
				format.js
			else
				format.html { redirect_to '/'+postable_path+'/'+post.postable_id.to_s, notice: 'Comment was not able to be created' }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
	end

	def destroy
	end

	private
	# Never trust parameters from the scary internet, only allow the white list through.
	def comment_params
	  params.require(:comment).permit(:text, :user_id, :post_id)
	end
end
