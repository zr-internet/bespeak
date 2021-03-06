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

ActiveRecord::Schema.define(:version => 20131204191408) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "bookings", :force => true do |t|
    t.integer  "course_id"
    t.integer  "customer_id"
    t.integer  "attendees"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "course_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "cost_cents",  :default => 0, :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.integer  "site_id"
  end

  add_index "course_types", ["site_id"], :name => "index_course_types_on_site_id"

  create_table "courses", :force => true do |t|
    t.integer  "office_id"
    t.integer  "course_type_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "max_occupancy"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "site_id"
  end

  add_index "courses", ["course_type_id"], :name => "index_courses_on_course_type_id"
  add_index "courses", ["office_id"], :name => "index_courses_on_office_id"
  add_index "courses", ["site_id"], :name => "index_courses_on_site_id"
  add_index "courses", ["start_at"], :name => "index_courses_on_start_at"

  create_table "customers", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "phone"
    t.integer  "site_id"
  end

  add_index "customers", ["reset_password_token"], :name => "index_customers_on_reset_password_token", :unique => true
  add_index "customers", ["site_id", "email"], :name => "index_customers_on_site_id_and_email", :unique => true
  add_index "customers", ["site_id"], :name => "index_customers_on_site_id"

  create_table "email_configurations", :force => true do |t|
    t.integer  "site_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "name"
    t.string   "key"
    t.string   "confirmation_template"
    t.string   "reminder_template"
  end

  add_index "email_configurations", ["site_id"], :name => "index_email_configurations_on_site_id"

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.string   "template"
    t.integer  "site_id"
    t.text     "options"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "phone"
    t.string   "time_zone"
    t.text     "directions"
    t.integer  "site_id"
  end

  add_index "offices", ["site_id"], :name => "index_offices_on_site_id"

  create_table "payment_processors", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "key"
    t.integer  "site_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "payment_processors", ["site_id"], :name => "index_payment_processors_on_site_id"

  create_table "payments", :force => true do |t|
    t.integer  "amount_cents", :default => 0,      :null => false
    t.string   "method",       :default => "cash", :null => false
    t.string   "token"
    t.integer  "booking_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "payments", ["booking_id"], :name => "index_payments_on_booking_id"

  create_table "sites", :force => true do |t|
    t.string   "token"
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "confirmation_url"
  end

  add_index "sites", ["token"], :name => "index_sites_on_token", :unique => true

end
