class AddEncryptableToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.encryptable
    end
  end

  def self.down
  end
end

