class CreateJudgments < ActiveRecord::Migration
  def self.up
    create_table :judgments do |t|
      t.integer :user_id
      t.integer :logical_form_id
      t.integer :realization_id
    end
    
    add_index :judgments,
      [:user_id, :logical_form_id, :realization_id], :unique => true
  end

  def self.down
    drop_table :judgments
  end
end
