class Helpoffer < ActiveRecord::Base
  before_create :write_topic

  belongs_to :user
  belongs_to :topic, :counter_cache => true

  validates :title, :presence	=> true

  

  private

  	def write_topic
  		# topic = Topic.check_topic(self.title)

  		# if topic
  		# 	self.topic_id = topic
  		# else
  			# new_topic = Topic.new(name:self.title)
  			# new_topic.save
  		
  		topic = Topic.where('lower(name) = ?', self.title.downcase).first

  		self.topic_id = topic.id

  		return true
  	end

end
