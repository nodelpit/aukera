class Movie < ApplicationRecord
  GENRES = [
    "Action", "Actualités", "Animation", "Aventure", "Comédie", "Crime", "Documentaire",
    "Drame", "Famille", "Fantaisie", "Guerre", "Histoire", "Horreur", "Musique",
    "Mystère", "Romance", "Science-Fiction", "Thriller", "Télé-réalité", "Western",
    "Émission de Talk Show"
  ]

  has_many :service_shows
  has_many :services, through: :service_shows
  has_many :movie_playlists
  has_many :playlists, through: :movie_playlists

  # validates :id_tmdb, presence: true
  validates :title, presence: true
  validates :real, presence: true
  validates :overview, presence: true
  validates :rating, presence: true
  validates :show_type, presence: true
  validates :horizontal_image_url, presence: true
  validates :vertical_image_url, presence: true
  # validates :trailer_link, presence: true
  validates :release_year, presence: true
  validates :runtime, presence: true
  validates :genre, inclusion: { in: GENRES }
end
