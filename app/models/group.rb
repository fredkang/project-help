class Group < ActiveRecord::Base
	has_many :groupusers, dependent: :destroy
	has_many :users, through: :groupusers
	has_many :posts, as: :postable, dependent: :destroy
	has_many :topics, through: :users
	has_many :helpoffers, through: :users

	validates :name, :presence		=> true

	def self.check_code(code)
		groups = self.all.to_a

		for i in 0...groups.length
			group = groups[i]

			if group.access_code == code
				return group.id
			end
		end

		return false
	end

	def self.user_get_groups(user_id)
		return Groupuser.select('group_id').where("user_id = ?", user_id.to_s).to_a
	end
end
