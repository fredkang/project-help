class AddUser2readToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :user2read, :integer
  end
end
