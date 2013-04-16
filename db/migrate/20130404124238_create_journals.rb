class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.integer :account_id, :null => false, :limit => 8
      t.string :title
      t.text :body, :null => false
      t.column :privacy, :enum, :limit => [:public, :friends_only, :private], :default => :public
      t.column :allow_comments, :enum, :limit => [:anyone, :friends_only, :none], :default => :anyone

      t.timestamps
    end
  end
end
