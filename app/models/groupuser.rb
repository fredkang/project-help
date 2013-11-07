class Groupuser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, :presence	=>	true
  validates :groupadmin, :presence => true
  validates :groupowner, :presence => true

  def self.group_user_exist?(group_id, user_id)
  	if self.where('group_id = ? and user_id = ?', group_id, user_id).blank?
  		return false
  	else
  		return true
  	end
  end
end
