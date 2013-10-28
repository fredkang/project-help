class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :postable, polymorphic:true

  has_many :comments, dependent: :destroy

  validates :text, :user_id, :postable_type, :postable_id, presence: true
end
