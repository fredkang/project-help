class Group < ActiveRecord::Base
	has_many :groupadmins, dependent: :destroy
	has_many :groupusers, dependent: :destroy
	has_many :users, through: :groupusers

	validates :name, :presence		=> true
end
