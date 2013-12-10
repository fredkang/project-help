class GroupsController < ApplicationController
  before_action :deny_access, only: [:show]

  def show
  	
  	if !Groupuser.where('group_id = ? and user_id = ?', params[:id], current_user.id).to_a.empty?
		@group = Group.find(params[:id])

		@users = @group.users.includes(:helpoffers).sort_by { |obj| obj.first_name } 		
		@posts = @group.posts.includes({comments: [{thanks: :thanker}, :user]}, {thanks: :thanker}, :user).order("created_at DESC")

		@newpost = session[:post] || @group.posts.new
	    session.delete(:post)
	    
	    current_user.notifications.where("notifiable_type = 'Group' and notifiable_id = ?", params[:id]).destroy_all
		
		
		# Rack::MiniProfiler.step("groupuser") do
		# 	belongs = Groupuser.where('group_id = ? and user_id = ?', params[:id], current_user.id)
		# end    
	else
		redirect_to "/users"
	end
  end
end
