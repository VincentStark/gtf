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

ActiveRecord::Schema.define(:version => 20120818081418) do

  create_table "measurement_values", :force => true do |t|
    t.integer  "measurement_id",              :null => false
    t.integer  "word_id"
    t.integer  "site_id"
    t.integer  "value",          :limit => 8, :null => false
    t.datetime "collected_at",                :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  add_index "measurement_values", ["measurement_id", "site_id", "value", "collected_at"], :name => "index_measurement_values_composite2", :unique => true
  add_index "measurement_values", ["measurement_id", "word_id", "site_id", "collected_at"], :name => "index_measurement_values_composite3", :unique => true
  add_index "measurement_values", ["measurement_id", "word_id", "value", "collected_at"], :name => "index_measurement_values_composite1", :unique => true

  create_table "measurements", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "mtype",      :null => false
    t.string   "url",        :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "measurements", ["name", "mtype", "url"], :name => "index_measurements_on_name_mtype_url", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sites", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sites", ["name"], :name => "index_sites_on_name", :unique => true

  create_table "words", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "words", ["name"], :name => "index_words_on_name", :unique => true

end
