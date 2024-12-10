class CreateServiceShows < ActiveRecord::Migration[7.2]
  def change
    create_table :service_shows do |t|
      t.references :service, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.string :link
      t.string :video_link

      t.timestamps
    end
  end
end
