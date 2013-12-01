class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :thanks, as: :thanked, class_name: "Thank", foreign_key: "thanked_id", dependent: :destroy

  validates :text, :user_id, :post_id, presence: true
end
