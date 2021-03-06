# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_08_07_042949) do

  create_table "url_aliases", force: :cascade do |t|
    t.string "alias", null: false
    t.string "url", null: false
    t.datetime "released_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["alias"], name: "index_url_aliases_on_alias"
    t.index ["alias"], name: "index_url_aliases_on_uniq_active_alias", unique: true, where: "released_at IS NULL"
    t.index ["url"], name: "index_url_aliases_on_url"
  end

end
