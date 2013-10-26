class Groupuser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  validates :user_id, :group_id, :presence	=>	true
  validates :groupadmin, :presence => true
  validates :groupowner, :presence => true
end
