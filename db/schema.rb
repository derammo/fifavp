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

ActiveRecord::Schema.define(:version => 20110610213739) do

  create_table "accomplishments", :force => true do |t|
    t.string   "section"
    t.integer  "linenumber"
    t.string   "description"
    t.integer  "skill_id"
    t.integer  "skillamount"
    t.string   "otherreward"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accomplishments", ["skill_id"], :name => "index_accomplishments_on_skill_id"

  create_table "assignments", :force => true do |t|
    t.integer  "role_id"
    t.integer  "position_id"
    t.integer  "suitability"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["position_id"], :name => "index_assignments_on_position_id"
  add_index "assignments", ["role_id"], :name => "index_assignments_on_role_id"

  create_table "games", :force => true do |t|
    t.integer  "league_id"
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "heightweights", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "weight"
  end

  create_table "heightweightvalues", :force => true do |t|
    t.integer  "heightweight_id"
    t.integer  "skill_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "heightweightvalues", ["heightweight_id"], :name => "index_heightweightvalues_on_heightweight_id"
  add_index "heightweightvalues", ["skill_id"], :name => "index_heightweightvalues_on_skill_id"

  create_table "leagueplayers", :force => true do |t|
    t.integer  "league_id"
    t.integer  "player_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playeraccomplishments", :force => true do |t|
    t.integer  "player_id"
    t.integer  "accomplishment_id"
    t.boolean  "achieved"
    t.datetime "when"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "playeraccomplishments", ["accomplishment_id"], :name => "index_playeraccomplishments_on_accomplishment_id"
  add_index "playeraccomplishments", ["player_id"], :name => "index_playeraccomplishments_on_player_id"

  create_table "players", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "owner"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gamertag"
  end

  create_table "positioncoefficients", :force => true do |t|
    t.integer  "position_id"
    t.integer  "skill_id"
    t.integer  "coefficient"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "positioncoefficients", ["position_id"], :name => "index_positioncoefficients_on_position_id"
  add_index "positioncoefficients", ["skill_id"], :name => "index_positioncoefficients_on_skill_id"

  create_table "positions", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "game_id"
    t.string   "hashfive"
    t.string   "player1"
    t.string   "team1"
    t.integer  "goals1"
    t.string   "player2"
    t.string   "team2"
    t.integer  "goals2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rolevalues", :force => true do |t|
    t.integer  "role_id"
    t.integer  "skill_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rolevalues", ["role_id"], :name => "index_rolevalues_on_role_id"
  add_index "rolevalues", ["skill_id"], :name => "index_rolevalues_on_skill_id"

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["source_id"], :name => "index_skills_on_source_id"

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
