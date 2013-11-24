class Topic < ActiveRecord::Base
	before_save :default_values
	has_many :helpoffers, :counter_cache => true
	has_many :users, through: :helpoffers

	validates :name, :presence => true

	def self.check_topic(topic_to_check)
		topics = self.all.to_a

		topics.each do |topic|
			if topic_to_check.downcase == topic.name.downcase
				return topic.id
			end
		end

		# self.new(name:topic_to_check).save

		return false
	end

	private
		def default_values
			self.click_count||=0
		end

end
