class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  belongs_to :conversation, :inverse_of => :messages

  validates :sender_id, :receiver_id, :text, presence: true
  validates_presence_of :conversation
end
