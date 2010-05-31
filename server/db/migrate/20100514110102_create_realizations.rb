class CreateRealizations < ActiveRecord::Migration
  def self.up
    create_table :realizations do |t|
      t.integer :logical_form_id
      t.string :sentence

      t.timestamps
    end
  end

  def self.down
    drop_table :realizations
  end
end
