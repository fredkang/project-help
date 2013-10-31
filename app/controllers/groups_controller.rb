class GroupsController < ApplicationController
  def show
  	@group = Group.find(params[:id])
  	@users = @group.users.all

  	@posts = @group.posts.order("created_at DESC").all
    @newpost = @group.posts.new

    current_user.notifications.where("notifiable_type = 'Group'").destroy_all
  end
end
