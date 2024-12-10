class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies do |t|
      t.integer :streaming_api_id
      t.string :tmdb_id
      t.string :title
      t.string :real
      t.string :cast
      t.string :genres
      t.integer :release_year
      t.integer :runtime
      t.string :overview
      t.integer :rating
      t.string :show_type
      t.string :video_link
      t.string :image_url
      t.string :trailer_link

      t.timestamps
    end
  end
end
