class AddIndexesToUsersEmailAndUsername < ActiveRecord::Migration
  def change
    add_index :users, :username, unique: true
    add_index :users, :email_address, unique: true
  end
end
