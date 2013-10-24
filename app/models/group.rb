class Group < ActiveRecord::Base
	has_many :groupadmins
	has_many :groupusers
end
