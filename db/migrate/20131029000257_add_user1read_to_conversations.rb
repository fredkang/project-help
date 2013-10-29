class AddUser1readToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :user1read, :integer
  end
end
