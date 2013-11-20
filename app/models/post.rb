class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :postable, polymorphic:true

  has_many :comments, dependent: :destroy

  validates :text, :user_id, :postable_type, :postable_id, presence: true

  def self.new_day_posts(user)
  	# Return a hash with the keys being the groups the user is in with new posts in them that day
  	# and the values being the number of new posts
  	new_posts = {}
    profile_posts = []
    group_posts = {}

  	posts_today = self.where("DATE(created_at) = DATE(?)", Time.now)
  	users_groups = user.groups.all

  	posts_today.each do |post|
  		if post.postable_type == "User" && post.postable_id == user.id
  			profile_posts.push(post)
  		elsif post.postable_type == "Group" && Groupuser.group_user_exist?(post.postable_id, user.id)
  			if group_posts[post.postable_id].nil?
          group_posts[post.postable_id] = []
  				group_posts[post.postable_id][0] = post
  			else
  				group_posts[post.postable_id].push(post)
  			end
  		end
  	end

  	return profile_posts, group_posts
  end

end
