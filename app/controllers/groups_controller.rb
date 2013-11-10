class GroupsController < ApplicationController
  before_action :deny_access, only: [:show]

  def show

  	if Groupuser.group_user_exist?(params[:id], current_user.id)
	  	@group = Group.find(params[:id])
	  	@users = @group.users.all.to_a.sort_by { |obj| obj.first_name }

	  	@posts = @group.posts.order("created_at DESC").all
	    @newpost = @group.posts.new

	    current_user.notifications.where("notifiable_type = 'Group'").destroy_all
	else
		redirect_to "/users"
	end
  end
end
