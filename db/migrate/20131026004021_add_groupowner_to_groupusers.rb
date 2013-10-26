class AddGroupownerToGroupusers < ActiveRecord::Migration
  def change
    add_column :groupusers, :groupowner, :integer
  end
end
