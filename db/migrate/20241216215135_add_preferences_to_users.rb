class AddPreferencesToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :preferred_platforms, :string
    add_column :users, :preferred_genres, :string
  end
end
