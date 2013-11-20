class AddTopicIdToHelpoffers < ActiveRecord::Migration
  def up
    add_reference :helpoffers, :topic, index: true

    Helpoffer.reset_column_information

    Helpoffer.all.to_a.each do |offer|
    	topic = Topic.where('name = ?', offer.title).first
    	offer.topic_id = topic.id
    	offer.save
    end
  end

  def down
  	remove_reference :helpoffers, :topic
  end

end