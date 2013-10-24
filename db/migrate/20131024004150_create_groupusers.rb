class CreateGroupusers < ActiveRecord::Migration
  def change
    create_table :groupusers do |t|
      t.references :user, index: true
      t.references :group, index: true

      t.timestamps
    end
  end
end
