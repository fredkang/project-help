class ConversationsController < ApplicationController
  def create

  	@conversation = Conversation.new(conversation_params)

    respond_to do |format|

      #If the new user is saved without error, automatically create an entry in Groupuser to add this user to Group 1.
      #Then sign in the user
      if @conversation.save
        format.html { redirect_to '/users/'+conversation_params['user2_id'].to_s } #@user, notice: 'User was successfully created.' }
        # format.json { render action: 'users#show', status: :created, location: @user }
      else
      	@conversation.errors.full_messages.each do |msg|
      		puts msg
      	end
        format.html { redirect_to '/users/'+conversation_params['user2_id'].to_s, notice: "Message not sent" } 
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if Conversation.ownsConvo?(current_user.id, params[:id])
      @conversation = Conversation.find(params[:id])

      if Conversation.read?(params[:id], current_user.id)==0
        Conversation.mark_as_read(params[:id], current_user.id)
      end
    else
      redirect_to '/users'
    end
  end

  def index
    @conversations = Conversation.getConvos(current_user.id)
  end

  def update
  	@conversation = Conversation.getConvo(params['conversation']['messages_attributes']['0']['sender_id'], params['conversation']['messages_attributes']['0']['receiver_id'])

  	respond_to do |format|
      if @conversation.update_attributes(conversation_params)
        format.html { redirect_to '/users/'+conversation_params['user2_id'].to_s } #@user, notice: 'User was successfully created.' }
        # format.json { render action: 'users#show', status: :created, location: @user }
      else
        format.html { redirect_to '/users/'+conversation_params['user2_id'].to_s, notice: "Message not sent" } 
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:user1_id, :user2_id, :user1read, :user2read, messages_attributes: [:id, :conversation_id, :sender_id, :receiver_id, :text])
    end
end
