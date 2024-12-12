class RemoveVideoLinkFromMovies < ActiveRecord::Migration[7.2]
  def change
    remove_column :movies, :video_link, :string
  end
end
