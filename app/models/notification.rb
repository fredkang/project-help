class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic:true

  validates :user_id, :notifiable_type, :notifiable_id, presence: true
end
