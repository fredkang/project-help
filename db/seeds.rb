# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
offers = Helpoffer.all.to_a

offers.each do |offer|
	if Topic.where('name = ?', offer.title).blank?
		Topic.create(name: offer.title, click_count: 0)
	end
end

# Topic.all.to_a.each do |topic|
# 	Topic.update_counters topic.id, :helpoffers_count => topic.helpoffers.length
# end