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

ActiveRecord::Schema.define(:version => 20130608152944) do

  create_table "attachments", :force => true do |t|
    t.integer  "listing_id"
    t.text     "description"
    t.string   "file_name"
    t.string   "file_path"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "identities", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "name"
  end

  create_table "listings", :force => true do |t|
    t.string   "listing_type"
    t.integer  "price"
    t.float    "laonpayment"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.integer  "squarefootage"
    t.float    "costpersqft"
    t.string   "adjustment_type"
    t.integer  "yearbuilt"
    t.integer  "lotsize"
    t.integer  "daysontapski"
    t.string   "neighbourhood"
    t.string   "mls"
    t.boolean  "status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.text     "description"
    t.text     "tap_description"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.integer  "user_id"
    t.string   "name"
    t.float    "lat"
    t.float    "long"
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.boolean  "sender_deleted",    :default => false
    t.boolean  "recipient_deleted", :default => false
    t.string   "subject"
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "listing_id"
  end

  create_table "pictures", :force => true do |t|
    t.integer  "listing_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.binary   "data"
  end

  create_table "residential_types", :force => true do |t|
    t.string "name"
  end

  create_table "search", :force => true do |t|
    t.string  "buy_rent"
    t.integer "pricerange"
    t.integer "beds"
    t.integer "bath"
    t.string  "keywords"
    t.integer "zip"
    t.string  "propertytype"
    t.integer "tapratings"
    t.boolean "wanted"
    t.string  "email"
    t.integer "agent_id"
    t.integer "user_id"
    t.integer "max_amount"
    t.integer "min_amount"
    t.integer "days_before"
    t.string  "name"
  end

  create_table "tap_question_answers", :force => true do |t|
    t.integer "listing_id"
    t.integer "question_id"
    t.string  "answer_text"
    t.string  "description"
  end

  create_table "tap_score_details", :force => true do |t|
    t.float   "tap_score"
    t.string  "features"
    t.boolean "must_sell"
  end

  create_table "tap_score_questions", :force => true do |t|
    t.string "question_text"
    t.string "answer_type"
  end

  create_table "user_details", :force => true do |t|
    t.integer  "picture_id"
    t.boolean  "profile_public"
    t.string   "full_name"
    t.text     "full_address"
    t.integer  "phone"
    t.string   "email"
    t.string   "updated_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.integer  "zip"
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "votes", :force => true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], :name => "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["votable_id", "votable_type"], :name => "index_votes_on_votable_id_and_votable_type"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], :name => "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
