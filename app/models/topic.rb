class Topic < ActiveRecord::Base
	has_many :helpoffers, :counter_cache => true

end
