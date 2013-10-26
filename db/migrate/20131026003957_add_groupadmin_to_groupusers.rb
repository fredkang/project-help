class AddGroupadminToGroupusers < ActiveRecord::Migration
  def change
    add_column :groupusers, :groupadmin, :integer
  end
end
