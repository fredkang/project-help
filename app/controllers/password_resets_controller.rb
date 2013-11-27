class PasswordResetsController < ApplicationController
  	def new
  	end

	def create
	  	user = User.find_by_email(params[:email])

	  	if user
			user.send_password_reset
			redirect_to root_url, :notice => "Email sent with password reset instructions."
		else
			redirect_to :back, :notice => "Invalid email"
		end
	end
end
