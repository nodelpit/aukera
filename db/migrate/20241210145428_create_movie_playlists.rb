class CreateMoviePlaylists < ActiveRecord::Migration[7.2]
  def change
    create_table :movie_playlists do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
