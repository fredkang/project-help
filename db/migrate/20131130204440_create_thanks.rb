class CreateThanks < ActiveRecord::Migration
  def change
    create_table :thanks do |t|
      t.integer :thanker_id
      t.references :thanked, polymorphic: true, index: true
      t.integer :thanked_uid

      t.timestamps
    end
  end
end
