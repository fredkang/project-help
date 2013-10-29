class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :sender, index: true
      t.references :receiver, index: true
      t.references :conversation, index: true
      t.text :text

      t.timestamps
    end
  end
end
