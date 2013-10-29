class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :conversation

  validates :sender_id, :receiver_id, :conversation_id, :text, presence: true
end
