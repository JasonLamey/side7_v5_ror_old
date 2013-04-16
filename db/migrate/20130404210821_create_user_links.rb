class CreateUserLinks < ActiveRecord::Migration
  def change
    create_table :user_links do |t|
      t.integer :account_id, :null => false, :limit => 8
      t.string :name, :null => false
      t.string :url, :null => false
      t.integer :nsfw, :null => false, :limit => 1, :default => 0
      t.integer :sort_order, :limit => 5
      t.integer :click_throughs, :limit => 8

      t.timestamps
    end
  end
end
