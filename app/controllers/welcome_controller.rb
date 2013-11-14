class WelcomeController < ApplicationController
  def index
  	@user = User.new

  	if signed_in?
  		redirect_to "/users"
  	end
  end

  def introduction
  end
end
