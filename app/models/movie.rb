class Movie < ApplicationRecord
  has_many :service_shows
  has_many :services, through: :service_shows
  has_many :movie_playlists
  has_many :playlists, through: :movie_playlists

  validates :title, presence: true
  validates :real, presence: true
  validates :overview, presence: true
  validates :rating, presence: true
  validates :showType, presence: true
  validates :video_link, presence: true
  validates :image_url, presence: true
  validates :trailer_link, presence: true
  validates :releaseYear, presence: true
  validates :runtime, presence: true

end
