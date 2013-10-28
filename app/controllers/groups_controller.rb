class GroupsController < ApplicationController
  def show
  	@group = Group.find(params[:id])
  	@users = @group.users.all

  	@posts = @group.posts.order("created_at DESC").all
    @newpost = @group.posts.new
  end
end
