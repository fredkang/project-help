class WelcomeController < ApplicationController
  def index
  	@user = User.new

  	if signed_in?
  		redirect_to "/network"
  	end
  end

  def introduction
  end
end
