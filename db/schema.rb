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

ActiveRecord::Schema[7.2].define(version: 2024_12_11_160427) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movie_playlists", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "playlist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_movie_playlists_on_movie_id"
    t.index ["playlist_id"], name: "index_movie_playlists_on_playlist_id"
  end

  create_table "movies", force: :cascade do |t|
    t.integer "streaming_api_id"
    t.string "tmdb_id"
    t.string "title"
    t.string "real"
    t.string "cast"
    t.string "genres"
    t.integer "release_year"
    t.integer "runtime"
    t.string "overview"
    t.integer "rating"
    t.string "show_type"
    t.string "video_link"
    t.string "trailer_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "vertical_image_url"
    t.string "horizontal_image_url"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_playlists_on_user_id"
  end

  create_table "service_shows", force: :cascade do |t|
    t.bigint "service_id", null: false
    t.bigint "movie_id", null: false
    t.string "link"
    t.string "video_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_service_shows_on_movie_id"
    t.index ["service_id"], name: "index_service_shows_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fav_genres"
    t.string "fav_acteur"
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.bigint "service_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["service_id"], name: "index_users_on_service_id"
  end

  add_foreign_key "movie_playlists", "movies"
  add_foreign_key "movie_playlists", "playlists"
  add_foreign_key "playlists", "users"
  add_foreign_key "service_shows", "movies"
  add_foreign_key "service_shows", "services"
  add_foreign_key "users", "services"
end
