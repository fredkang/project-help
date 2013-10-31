class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :notifiable, polymorphic: true

      t.timestamps
    end
  end
end
