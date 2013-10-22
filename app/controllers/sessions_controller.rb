class SessionsController < ApplicationController
  def create
  	user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])

  	if user == false || user.nil?
  		redirect_to "/users/new", flash: {log_errors: "Incorrect email/password" }
  	else
  		sign_in(user)
  		redirect_to "/users"
  	end
  end

  def destroy
  	sign_out
  	redirect_to "/users/new"
  end
end
