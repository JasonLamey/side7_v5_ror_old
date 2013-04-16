class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
      t.integer :account_id,                :limit => 8
      t.integer :display_signature,         :limit => 1, :default => 1
      t.integer :show_management_thumbs,    :limit => 1, :default => 1
      t.column :default_comment_visibility, :enum, :limit => [:show, :hide], :default => :show
      t.column :default_comment_type,       :enum, :limit => [:any, :commentary, :light_critique, :heavy_critique], :default => :any
      t.integer :allow_watching,            :limit => 1, :default => 1
      t.integer :allow_favoriting,          :limit => 1, :default => 1
      t.integer :allow_email_through_forms, :limit => 1, :default => 1
      t.integer :allow_pms,                 :limit => 1, :default => 1
      t.integer :pms_notifications,         :limit => 1, :default => 1
      t.integer :comment_notifications,     :limit => 1, :default => 1
      t.integer :show_online,               :limit => 1, :default => 1
      t.column :thumbnail_size,             :enum, :limit => [:small, :large], :default => :small
      t.column :content_display_type,       :enum, :limit => [:list, :grid], :default => :list
      t.integer :show_m_thumbs,             :limit => 1, :default => 0
      t.integer :show_adult_content,        :limit => 1, :default => 0
      t.column :display_full_sized_images,  :enum, :limit => [:same_window, :new_window], :default => :same_window

      t.timestamps
    end

    add_index :user_preferences, :account_id
  end
end
