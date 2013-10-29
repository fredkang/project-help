class Conversation < ActiveRecord::Base
  belongs_to :user1, class_name: "User", foreign_key: "user1_id"
  belongs_to :user2, class_name: "User", foreign_key: "user2_id"

  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :messages

  validates :user1_id, :user2_id, :user1_read, :user2_read, presence: true

  def read?(user_id)
  	if self.user1_id == user_id
  		return self.user1_read
  	elsif self.user2_id == user_id
  		return self.user2_read
  	else
  		return "Blah"
  	end
  end
  
end
