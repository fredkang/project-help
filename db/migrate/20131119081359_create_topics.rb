class CreateTopics < ActiveRecord::Migration
  def up
    create_table :topics do |t|
      t.string :name
      t.integer :click_count
      t.integer :helpoffers_count

      t.timestamps
    end

    Topic.reset_column_information

    offers = Helpoffer.all.to_a

	offers.each do |offer|
		if Topic.where('name = ?', offer.title).blank?
			Topic.create(name: offer.title, click_count: 0, helpoffers_count: 0)
		end
	end
  end

  def down
  	drop_table :topics
  end
end
