class PostsController < ApplicationController
  def create
  	@post = Post.new(post_params)

  	if(post_params['postable_type'] == 'User')
  		postable = User.find(post_params['postable_id'])
  		postable_path = "users"
  	else
  		postable = Group.find(post_params['postable_id'])
  		postable_path = "groups"
  	end

  	respond_to do |format|

		if @post.save
      # When a new post is created in a group, create new notifications for each person in that group
      if @post.postable_type == "Group"
        users = Group.find(@post.postable_id).users.all

        users.each do |user|
          Notification.new(:notifiable_id=>@post.postable_id, :notifiable_type=>"Group", :user_id=>user.id).save
        end

      # When a new post is created on a user's profile, create a new notification for that user
      else
        Notification.new(:notifiable_id=>@post.postable_id, :notifiable_type=>"User", :user_id=>@post.postable_id).save
      end

			format.html { redirect_to '/'+postable_path+'/'+post_params['postable_id'] } #@user, notice: 'User was successfully created.' }
			format.json { render action: postable_path+'#show', status: :created, location: @post }
		else
			format.html { redirect_to '/'+postable_path+'/'+post_params['postable_id'], notice: 'Post was not able to be created' }
			format.json { render json: @user.errors, status: :unprocessable_entity }
		end
	end
  end

  def update
  end

  def destroy
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:text, :user_id, :postable_id, :postable_type)
    end
end
