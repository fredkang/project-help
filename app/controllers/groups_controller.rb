class GroupsController < ApplicationController
  before_action :deny_access, only: [:show]

  def show

  	if Groupuser.group_user_exist?(params[:id], current_user.id)
	  	@group = Group.find(params[:id])
	  	@users = @group.users.includes(:helpoffers).sort_by { |obj| obj.first_name }

	  	@posts = @group.posts.includes(:comments).order("created_at DESC")
	    
	    @newpost = session[:post] || @group.posts.new
	    session.delete(:post)

	    current_user.notifications.where("notifiable_type = 'Group' and notifiable_id = ?", params[:id]).destroy_all
	else
		redirect_to "/users"
	end
  end
end
