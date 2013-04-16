class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :account_id, :limit => 8, :null => false
      t.integer :friend_id, :limit => 8, :null => false
      t.integer :approved, :limit => 1, :null => false, :default => 0

      t.timestamps
    end

    add_index :friends, :account_id
    add_index :friends, :friend_id
    add_index :friends, [:account_id, :friend_id], unique: true
  end
end
