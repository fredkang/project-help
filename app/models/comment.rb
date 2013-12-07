class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :thanks, as: :thanked, class_name: "Thank", foreign_key: "thanked_id", dependent: :destroy

  validates :text, :user_id, :post_id, presence: true

  after_save :notify_post_creator

  private 
    def notify_post_creator
    	original_post = Post.find(post_id)

    	if original_post.user_id != user_id
	    	original_poster = User.find(original_post.user_id)
	    	commenter = User.find(user_id)

	  		UserMailer.comment_email(original_poster, commenter, self, original_post).deliver
	  	end
    end
end
