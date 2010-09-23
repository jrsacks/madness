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

ActiveRecord::Schema.define(:version => 20100312121227) do

  create_table "boxes", :force => true do |t|
    t.string   "boxid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "final_boxes", :force => true do |t|
    t.string   "boxid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "team"
    t.integer  "points"
    t.string   "boxid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.string   "p1name"
    t.string   "p1team"
    t.string   "p2name"
    t.string   "p2team"
    t.string   "p3name"
    t.string   "p3team"
    t.string   "p4name"
    t.string   "p4team"
    t.string   "p5name"
    t.string   "p5team"
    t.string   "p6name"
    t.string   "p6team"
    t.string   "p7name"
    t.string   "p7team"
    t.string   "p8name"
    t.string   "p8team"
    t.string   "p9name"
    t.string   "p9team"
    t.string   "p10name"
    t.string   "p10team"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "p1alive",    :default => true
    t.boolean  "p2alive",    :default => true
    t.boolean  "p3alive",    :default => true
    t.boolean  "p4alive",    :default => true
    t.boolean  "p5alive",    :default => true
    t.boolean  "p6alive",    :default => true
    t.boolean  "p7alive",    :default => true
    t.boolean  "p8alive",    :default => true
    t.boolean  "p9alive",    :default => true
    t.boolean  "p10alive",   :default => true
  end

end
