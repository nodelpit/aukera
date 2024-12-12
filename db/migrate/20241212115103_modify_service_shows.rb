class ModifyServiceShows < ActiveRecord::Migration[7.2]
  def change
    # Supprime la colonne video_link
    remove_column :service_shows, :video_link, :string

    # Ajoute la colonne access_type
    add_column :service_shows, :access_type, :string
  end
end
