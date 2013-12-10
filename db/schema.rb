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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131210031847) do

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thanks_count", default: 0
  end

  add_index "comments", ["created_at"], name: "index_comments_on_created_at"
  add_index "comments", ["post_id"], name: "index_comments_on_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "conversations", force: true do |t|
    t.integer  "user1_id"
    t.integer  "user2_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user1read"
    t.integer  "user2read"
  end

  add_index "conversations", ["user1_id"], name: "index_conversations_on_user1_id"
  add_index "conversations", ["user2_id"], name: "index_conversations_on_user2_id"

  create_table "group_admins", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_admins", ["group_id"], name: "index_group_admins_on_group_id"
  add_index "group_admins", ["user_id"], name: "index_group_admins_on_user_id"

  create_table "group_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id"
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id"

  create_table "groupadmins", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groupadmins", ["group_id"], name: "index_groupadmins_on_group_id"
  add_index "groupadmins", ["user_id"], name: "index_groupadmins_on_user_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "access_code"
  end

  create_table "groupusers", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "groupadmin"
    t.integer  "groupowner"
  end

  add_index "groupusers", ["group_id"], name: "index_groupusers_on_group_id"
  add_index "groupusers", ["user_id"], name: "index_groupusers_on_user_id"

  create_table "help_offers", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "help_offers", ["user_id"], name: "index_help_offers_on_user_id"

  create_table "helpoffers", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topic_id"
  end

  add_index "helpoffers", ["topic_id"], name: "index_helpoffers_on_topic_id"
  add_index "helpoffers", ["user_id"], name: "index_helpoffers_on_user_id"

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "conversation_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"

  create_table "notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "posts", force: true do |t|
    t.text     "text"
    t.integer  "user_id"
    t.integer  "postable_id"
    t.string   "postable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "thanks_count",  default: 0
    t.text     "title"
  end

  add_index "posts", ["created_at"], name: "index_posts_on_created_at"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "thanks", force: true do |t|
    t.integer  "thanker_id"
    t.integer  "thanked_id"
    t.string   "thanked_type"
    t.integer  "thanked_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "thanks", ["thanked_id", "thanked_type"], name: "index_thanks_on_thanked_id_and_thanked_type"

  create_table "topics", force: true do |t|
    t.string   "name"
    t.integer  "click_count"
    t.integer  "helpoffers_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "description"
    t.string   "password_digest"
    t.string   "phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin"
    t.string   "image"
    t.string   "current"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent"
    t.integer  "thanks_count",         default: 0
  end

end
