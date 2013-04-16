# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130412204359) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id",                 :limit => 8,                 :null => false
    t.string   "first_name",              :limit => 45
    t.string   "last_name",               :limit => 45
    t.integer  "user_type_id",            :limit => 1,  :default => 1, :null => false
    t.integer  "user_status_id",          :limit => 1,  :default => 1, :null => false
    t.date     "reinstate_on"
    t.string   "other_aliases"
    t.text     "biography"
    t.date     "birthday",                                             :null => false
    t.integer  "birthday_visibility",     :limit => 1,  :default => 1, :null => false
    t.string   "webpage_name"
    t.string   "webpage_url"
    t.string   "blog_name"
    t.string   "blog_url"
    t.string   "aim",                     :limit => 45
    t.string   "yahoo",                   :limit => 45
    t.string   "gtalk",                   :limit => 45
    t.string   "skype",                   :limit => 45
    t.string   "state"
    t.integer  "country_id"
    t.integer  "is_public",               :limit => 3
    t.integer  "referred_by",             :limit => 8
    t.date     "subscription_expires_on"
    t.date     "delete_on"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "countries", :force => true do |t|
    t.string   "name",       :limit => 45
    t.string   "code",       :limit => 3
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "date_visibilities", :force => true do |t|
    t.string   "visibility", :limit => 45
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "friends", :force => true do |t|
    t.integer  "account_id", :limit => 8,                :null => false
    t.integer  "friend_id",  :limit => 8,                :null => false
    t.integer  "approved",   :limit => 1, :default => 0, :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "friends", ["account_id", "friend_id"], :name => "index_friends_on_account_id_and_friend_id", :unique => true
  add_index "friends", ["account_id"], :name => "index_friends_on_account_id"
  add_index "friends", ["friend_id"], :name => "index_friends_on_friend_id"

  create_table "journals", :force => true do |t|
    t.integer  "account_id",     :limit => 8,                                                       :null => false
    t.string   "title"
    t.text     "body",                                                                              :null => false
    t.enum     "privacy",        :limit => [:public, :friends_only, :private], :default => :public
    t.enum     "allow_comments", :limit => [:anyone, :friends_only, :none],    :default => :anyone
    t.datetime "created_at",                                                                        :null => false
    t.datetime "updated_at",                                                                        :null => false
  end

  create_table "museums", :force => true do |t|
    t.integer  "watcher_id"
    t.integer  "watched_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "museums", ["watched_id"], :name => "index_museums_on_watched_id"
  add_index "museums", ["watcher_id", "watched_id"], :name => "index_museums_on_watcher_id_and_watched_id", :unique => true
  add_index "museums", ["watcher_id"], :name => "index_museums_on_watcher_id"

  create_table "user_links", :force => true do |t|
    t.integer  "account_id",     :limit => 8,                :null => false
    t.string   "name",                                       :null => false
    t.string   "url",                                        :null => false
    t.integer  "nsfw",           :limit => 1, :default => 0, :null => false
    t.integer  "sort_order",     :limit => 8
    t.integer  "click_throughs", :limit => 8
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "user_preferences", :force => true do |t|
    t.integer  "account_id",                 :limit => 8
    t.integer  "display_signature",          :limit => 1,                                                     :default => 1
    t.integer  "show_management_thumbs",     :limit => 1,                                                     :default => 1
    t.enum     "default_comment_visibility", :limit => [:show, :hide],                                        :default => :show
    t.enum     "default_comment_type",       :limit => [:any, :commentary, :light_critique, :heavy_critique], :default => :any
    t.integer  "allow_watching",             :limit => 1,                                                     :default => 1
    t.integer  "allow_favoriting",           :limit => 1,                                                     :default => 1
    t.integer  "allow_email_through_forms",  :limit => 1,                                                     :default => 1
    t.integer  "allow_pms",                  :limit => 1,                                                     :default => 1
    t.integer  "pms_notifications",          :limit => 1,                                                     :default => 1
    t.integer  "comment_notifications",      :limit => 1,                                                     :default => 1
    t.integer  "show_online",                :limit => 1,                                                     :default => 1
    t.enum     "thumbnail_size",             :limit => [:small, :large],                                      :default => :small
    t.enum     "content_display_type",       :limit => [:list, :grid],                                        :default => :list
    t.integer  "show_m_thumbs",              :limit => 1,                                                     :default => 0
    t.integer  "show_adult_content",         :limit => 1,                                                     :default => 0
    t.enum     "display_full_sized_images",  :limit => [:same_window, :new_window],                           :default => :same_window
    t.datetime "created_at",                                                                                                            :null => false
    t.datetime "updated_at",                                                                                                            :null => false
  end

  add_index "user_preferences", ["account_id"], :name => "index_user_preferences_on_account_id"

  create_table "user_statuses", :force => true do |t|
    t.string   "user_status"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_types", :force => true do |t|
    t.string   "user_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email_address"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

  add_index "users", ["email_address"], :name => "index_users_on_email_address", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
