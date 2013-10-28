class Group < ActiveRecord::Base
	has_many :groupusers, dependent: :destroy
	has_many :users, through: :groupusers
	has_many :posts, as: :postable, dependent: :destroy

	validates :name, :presence		=> true
end
