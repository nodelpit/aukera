class RemoveFavGenresFavActeurAndServiceIdFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :fav_genres, :string
    remove_column :users, :fav_acteur, :string
    remove_reference :users, :service, foreign_key: true
  end
end
