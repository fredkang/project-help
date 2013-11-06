class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :conversation, :inverse_of => :messages

  validates :sender_id, :receiver_id, :text, presence: true
  validates_presence_of :conversation

  after_save :notify_receiver


  private 
    def notify_receiver
      # sendText(:sender_id, :receiver_id, :text)
      ApplicationController.helpers.sendText("#{sender_id}", "#{receiver_id}", "#{text}")

      UserMailer.message_email(User.find(receiver_id), User.find(sender_id), text, conversation_id).deliver
    end
end
