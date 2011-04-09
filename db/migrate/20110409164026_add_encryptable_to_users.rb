class AddEncryptableToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      execute "ALTER TABLE users DROP COLUMN password_salt"
      t.encryptable
    end
  end

  def self.down
  end
end

