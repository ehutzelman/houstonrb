# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100501221601) do

  create_table "books", :force => true do |t|
    t.string    "asin"
    t.string    "title"
    t.string    "authors"
    t.string    "url"
    t.string    "image_url"
    t.timestamp "published_at"
    t.boolean   "available"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "meetings", :force => true do |t|
    t.string    "title"
    t.string    "description"
    t.string    "location"
    t.timestamp "start_at"
    t.timestamp "end_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "topic_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.string   "description"
    t.integer  "requester_user_id"
    t.integer  "presenter_user_id"
    t.boolean  "is_active",         :default => true
    t.integer  "topic_votes_count", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "identity_url"
    t.string    "name"
    t.string    "email"
    t.text      "bio"
    t.string    "url"
    t.string    "twitter"
    t.boolean   "display"
    t.boolean   "available"
    t.timestamp "last_login_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

end
