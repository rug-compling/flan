class AddPdfToLogicalForms < ActiveRecord::Migration
  def self.up
    add_column :logical_forms, :pdf, :text
  end

  def self.down
    remove_column :logical_forms, :pdf
  end
end
