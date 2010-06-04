class AddUserIdPublishedToRealization < ActiveRecord::Migration
  def self.up
    add_column :realizations, :user_id, :integer
    add_column :realizations, :published, :boolean, :default => 0
  end

  def self.down
    remove_column :realizations, :published
    remove_column :realizations, :user_id
  end
end
