class Conversation < ActiveRecord::Base
  belongs_to :user1, class_name: "User", foreign_key: "user1_id"
  belongs_to :user2, class_name: "User", foreign_key: "user2_id"

  has_many :messages, dependent: :destroy, :inverse_of => :conversation

  accepts_nested_attributes_for :messages, allow_destroy: true

  validates :user1_id, :user2_id, :user1read, :user2read, presence: true

  def self.read?(user_id)
  	if self.user1_id == user_id
  		return self.user1_read
  	elsif self.user2_id == user_id
  		return self.user2_read
  	else
  		return "Blah"
  	end
  end

  def self.getConvo(id1, id2)
    convo1 = self.where("user1_id= ? and user2_id= ?", id1, id2)
    convo2 = self.where("user1_id= ? and user2_id= ?", id2, id1)
    if convo1
      return convo1.first
    elsif convo2
      return convo2.first
    else
      return nil
    end
  end

  def self.getConvos(id)
    convos = self.where("user1_id= ? or user2_id= ?", id, id)

    return convos
  end
  
end
