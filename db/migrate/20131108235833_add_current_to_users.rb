class AddCurrentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current, :string
  end
end
