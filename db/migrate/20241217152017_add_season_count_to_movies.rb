class AddSeasonCountToMovies < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :season_count, :integer, default: 0
  end
end
