class CreateLogicalForms < ActiveRecord::Migration
  def self.up
    create_table :logical_forms do |t|
      t.string :key
      t.text :data

      t.timestamps
    end
  end

  def self.down
    drop_table :logical_forms
  end
end
