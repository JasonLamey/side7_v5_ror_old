class CreateMuseums < ActiveRecord::Migration
  def change
    create_table :museums do |t|
      t.integer :watcher_id
      t.integer :watched_id

      t.timestamps
    end

    add_index :museums, :watcher_id
    add_index :museums, :watched_id
    add_index :museums, [:watcher_id, :watched_id], unique: true
  end
end
