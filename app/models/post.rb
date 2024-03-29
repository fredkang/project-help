class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :postable, polymorphic:true

  has_many :comments, dependent: :destroy, :order => 'created_at ASC'
  has_many :thanks, as: :thanked, class_name: "Thank", foreign_key: "thanked_id", dependent: :destroy

  validates :user_id, :postable_type, :postable_id, presence: true
  validates :title, presence: true, if: :group_post?
  validates :text, presence: true, if: :profile_post?

  def group_post?
    self.postable_type == "Group"
  end

  def profile_post?
    self.postable_type == "User"
  end

  def self.new_day_posts(user)
  	# Return a hash with the keys being the groups the user is in with new posts in them that day
  	# and the values being the number of new posts
  	new_posts = {}
    profile_posts = []
    group_posts = {}

  	# posts_today = self.where("DATE(created_at) = DATE(?)", Time.now)
    posts_today = self.where("created_at > ?", DateTime.now-24.hours)
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

  # def self.get_response_users(post, comment)
  #   users = []

  #   users.push(post.user)

  #   comments = Post.comments.includes(:user).where('created_at < ?', comment.created_at )

  #   comments.each
  # end

end
