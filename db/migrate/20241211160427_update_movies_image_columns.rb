class UpdateMoviesImageColumns < ActiveRecord::Migration[7.2]
  def change
    remove_column :movies, :image_url, :string
    add_column :movies, :vertical_image_url, :string
    add_column :movies, :horizontal_image_url, :string
  end
end
