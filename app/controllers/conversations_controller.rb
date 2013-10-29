class ConversationsController < ApplicationController
  def create

  end

  def show
  end

  def index
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:user1_id, :user2_id, :user1read, :user2read, messages_attributes: [:text])
    end
end
