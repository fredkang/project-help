class Thank < ActiveRecord::Base
  belongs_to :thanked, polymorphic: true, :counter_cache => true
  belongs_to :thanker, class_name: "User", foreign_key: "thanker_id"
  # belongs_to :thanked_user, class_name: "User", foreign_key: "thanked_uid", :counter_cache => true
  
  before_save :assign_thanked_uid
  after_save :increment_thanked_user

  private 
  	def assign_thanked_uid
  		if self.thanked_type == "User"
  			self.thanked_uid = self.thanked_id
  		elsif self.thanked_type == "Post"
  			self.thanked_uid = Post.find(self.thanked_id).user_id
  		else
  			self.thanked_uid = Comment.find(self.thanked_id).user_id
  		end
  	end

  	def increment_thanked_user
  		if self.thanked_type != "User"
  			User.increment_counter(:thanks_count, self.thanked_uid)
  		end
  	end
end
