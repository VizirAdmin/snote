class AddIndexOnUserIdToNotes < ActiveRecord::Migration
  def self.up
    add_index :notes, :user_id
  end

  def self.down
  end
end

