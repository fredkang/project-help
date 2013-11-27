class PasswordResetsController < ApplicationController
  	def new
  	end

  	# Accepts the input of a password_reset request
	def create
		# Grab the user associated with this email
	  	user = User.find_by_email(params[:email])

	  	# If the user exists, send them a link to reset the password, otherwise return them back
	  	# to the previous page with the error
	  	if user
			user.send_password_reset
			redirect_to "/users/new", :notice => "Email sent with password reset instructions."
		else
			redirect_to :back, :notice => "Invalid email"
		end
	end

	def edit
		@user = User.find_by_password_reset_token!(params[:id])
	end

	def update
		@user = User.find_by_password_reset_token!(params[:id])
		
		puts "User params are: "
		puts params[:user]
		if @user.password_reset_sent < 2.hours.ago
	    	redirect_to new_password_reset_path, :notice => "Password reset has expired. Please request a new password reset."
	  	elsif @user.update_attributes(user_params)
	  		sign_in(@user)
		    redirect_to "/welcome/index", :notice => "Password has been reset."
	  	else
		    render :edit
	  	end
	end

	private
		# Never trust parameters from the scary internet, only allow the white list through.
	    def user_params
	      params.require(:user).permit(:password, :password_confirmation)
	    end
end
