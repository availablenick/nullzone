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

ActiveRecord::Schema.define(version: 2019_06_19_064834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "denunciations", force: :cascade do |t|
    t.string "denunciador"
    t.string "denunciado"
    t.string "tipo"
    t.integer "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "posts", force: :cascade do |t|
    t.text "mensagem"
    t.string "video"
    t.bigint "topico_id"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topico_id"], name: "index_posts_on_topico_id"
    t.index ["usuario_id"], name: "index_posts_on_usuario_id"
  end

  create_table "topicos", force: :cascade do |t|
    t.string "titulo"
    t.text "mensagem"
    t.bigint "usuario_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_topicos_on_usuario_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "login"
    t.string "crypted_password"
    t.string "password_salt"
    t.string "persistence_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "posts", "topicos"
  add_foreign_key "posts", "usuarios"
  add_foreign_key "topicos", "usuarios"
end
