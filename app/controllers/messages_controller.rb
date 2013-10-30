class MessagesController < ApplicationController
  def create
  	@message = Message.new(message_params)

    respond_to do |format|

      #If the new user is saved without error, automatically create an entry in Groupuser to add this user to Group 1.
      #Then sign in the user
      if @message.save

      	# For every new message, mark the conversation as unread for the receiver
      	Conversation.mark_as_unread(message_params['conversation_id'], message_params['receiver_id'].to_i)
      	puts message_params['conversation_id'] + " " + message_params['receiver_id']

        format.html { redirect_to '/inbox/'+message_params['conversation_id'].to_s } #@user, notice: 'User was successfully created.' }
        # format.json { render action: 'users#show', status: :created, location: @user }
      else
      	@conversation.errors.full_messages.each do |msg|
      		puts msg
      	end
        format.html { redirect_to '/inbox/'+message_params['conversation_id'].to_s, notice: "Message not sent" } 
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:sender_id, :receiver_id, :conversation_id, :text)
    end
end
