class Topic < ActiveRecord::Base
	has_many :helpoffers, :counter_cache => true
	has_many :users, through: :helpoffers

end
