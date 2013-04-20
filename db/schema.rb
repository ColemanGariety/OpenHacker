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

ActiveRecord::Schema.define(:version => 20130419060029) do

  create_table "challenges", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "prize"
    t.string   "rules"
    t.integer  "status"
    t.datetime "opened_at"
  end

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "repo_url"
    t.string   "thumb_url"
    t.integer  "user_id"
    t.integer  "challenge_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "demo_url"
    t.integer  "github_repo_id"
    t.string   "platform"
  end

  create_table "users", :force => true do |t|
    t.string   "github_uid"
    t.string   "username"
    t.string   "email"
    t.string   "full_name"
    t.string   "gravatar_id"
    t.string   "blog_url"
    t.string   "company"
    t.string   "location"
    t.boolean  "hireable"
    t.text     "bio"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "ribbon_array"
    t.string   "github_token"
    t.string   "banned_at"
  end

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "value"
    t.integer  "entry_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "ignore",     :default => false
  end

end
