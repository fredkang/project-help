class GroupsController < ApplicationController
  def show
  	@group = Group.find(params[:id])
  	@users = @group.users.all
  end
end
