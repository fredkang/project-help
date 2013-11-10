module SessionsHelper
	def sign_in(user)
		session['user_id'] = user.id
		@current_user = user
	end

	def sign_out
		session['user_id'] = nil
		self.current_user = nil
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user
		@current_user ||= User.find(session['user_id']) if session['user_id']
	end

	def current_user?(user)
		current_user == user
	end

	def signed_in?
		current_user != nil
	end

	def deny_access
		if !signed_in?
			redirect_to "/users/new", :notice=>"Please sign in to access this page."
		end
	end

	def correct_user?
      if current_user.id.to_s != params[:id] && current_user.admin!=1
        redirect_to "/welcome/index"
      end
    end

	def unread_messages
		# Check and display the number of unread messages
		conversations = Conversation.getConvos(current_user.id)
		unread = 0

		conversations.each do |conversation|
			if Conversation.read?(conversation.id, current_user.id)==0
			  unread += 1
			end
		end

		return unread
	end

	def profile_notifications
		return current_user.profilenotes.count()
	end

	def total_group_notifications
		return current_user.notifications.where("notifiable_type = 'Group'").to_a.length
	end

	def group_notifications(group_id)
		return current_user.notifications.where("notifiable_type = 'Group' and notifiable_id = ?", group_id).to_a.length
	end

end
