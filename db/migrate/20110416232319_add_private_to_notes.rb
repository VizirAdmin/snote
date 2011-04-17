class AddPrivateToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :private, :boolean, :default => true
  end

  def self.down
    remove_column :notes, :private, :boolean
  end
end

