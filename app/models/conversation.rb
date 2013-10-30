class Conversation < ActiveRecord::Base
  belongs_to :user1, class_name: "User", foreign_key: "user1_id"
  belongs_to :user2, class_name: "User", foreign_key: "user2_id"

  has_many :messages, dependent: :destroy, :inverse_of => :conversation

  accepts_nested_attributes_for :messages, allow_destroy: true

  validates :user1_id, :user2_id, :user1read, :user2read, presence: true

  def self.read?(convo_id, user_id)
    convo = self.find(convo_id)

  	if convo.user1_id == user_id
  		return convo.user1read
  	elsif convo.user2_id == user_id
  		return convo.user2read
  	else
  		return 0
  	end
  end

  def self.mark_as_read(convo_id, user_id)
    convo = self.find(convo_id)

    if convo.user1_id == user_id
      convo.update_column('user1read', 1)
      # convo.user1read = 1
      # convo.save
    elsif convo.user2_id == user_id
      convo.update_column('user2read', 1)
      # convo.user2read = 1
      # convo.save
    else
      return 0
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

  def self.ownsConvo?(userID, convoID)
    convo = self.find(convoID)

    if userID != convo.user1_id && userID != convo.user2_id
      return false
    else
      return true
    end
  end
  
end
