class Group < ActiveRecord::Base
	has_many :groupusers, dependent: :destroy
	has_many :users, through: :groupusers
	has_many :posts, as: :postable, dependent: :destroy

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
end
