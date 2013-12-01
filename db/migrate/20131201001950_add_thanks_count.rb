class AddThanksCount < ActiveRecord::Migration
  def change
  	add_column :posts, :thanks_count, :integer, :default => 0
  	
  	add_column :comments, :thanks_count, :integer, :default => 0

  	add_column :users, :thanks_count, :integer, :default => 0
  end
end
