class AddNameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string, :unique => true
  end

  def self.down
    remove_column :users, :name, :string
  end
end

