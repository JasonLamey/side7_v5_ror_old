class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id, :null => false, :limit => 8
      t.string  :first_name, :limit => 45
      t.string  :last_name, :limit => 45
      t.integer :user_type_id, :default => 1, :null => false, :limit => 1
      t.integer :user_status_id, :default => 1, :null => false, :limit => 1
      t.date    :reinstate_on
      t.string  :other_aliases
      t.text    :biography
      t.date    :birthday, :null => false
      t.integer :birthday_visibility, :default => 1, :null => false, :limit => 1
      t.string  :webpage_name
      t.string  :webpage_url
      t.string  :blog_name
      t.string  :blog_url
      t.string  :aim, :limit => 45
      t.string  :yahoo, :limit => 45
      t.string  :gtalk, :limit => 45
      t.string  :skype, :limit => 45
      t.string  :state
      t.integer :country
      t.integer :is_public, :limit => 3
      t.integer :referred_by, :limit => 8
      t.date    :subscription_expires_on
      t.date    :delete_on

      t.timestamps
    end

    add_index :accounts, :user_id
  end
end
