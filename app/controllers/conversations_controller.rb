class ConversationsController < ApplicationController
  before_action :deny_access, only: [:create, :show, :index, :update]

  def create

  	@conversation = Conversation.new(conversation_params)

    respond_to do |format|

      #If the new user is saved without error, automatically create an entry in Groupuser to add this user to Group 1.
      #Then sign in the user
      if @conversation.save
        # sendText(conversation_params['messages_attributes']['0']['sender_id'], conversation_params['messages_attributes']['0']['receiver_id'], conversation_params['messages_attributes']['0']['text'])
        convoID = Conversation.getConvo(conversation_params['user2_id'], conversation_params['user1_id']).id
        format.html { redirect_to '/inbox/'+convoID.to_s } #@user, notice: 'User was successfully created.' }
        # format.json { render action: 'users#show', status: :created, location: @user }
      else
        format.html { redirect_to '/users/'+conversation_params['user2_id'].to_s, notice: "Message not sent" } 
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    # Check if the conversation belongs to this user, redirect to the network page otherwise
    if Conversation.ownsConvo?(current_user.id, params[:id])
      @conversation = Conversation.find(params[:id])

      # Also mark the conversation as read now that the user has gone into it
      if Conversation.read?(params[:id], current_user.id)==0
        Conversation.mark_as_read(params[:id], current_user.id)
      end

      # Check and display the number of unread messages
      conversations = Conversation.getConvos(current_user.id)
      @unread = unread_messages
      
      # conversations.each do |conversation|
      #   if Conversation.read?(conversation.id, current_user.id)==0
      #     @unread += 1
      #   end
      # end

    else
      redirect_to '/users'
    end
  end

  def index
    @conversations = Conversation.getConvos(current_user.id)

    @unread = unread_messages

    # @conversations.each do |conversation|
    #   if !Conversation.read?(conversation.id, current_user.id)
    #     @unread += 1
    #   end
    # end
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
