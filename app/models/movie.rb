class Movie < ApplicationRecord
  GENRES = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
    'Mystery',
    'News',
    'Non spécifié',
    'Reality',
    'Romance',
    'Science fiction',
    'Talk show',
    'Thriller',
    'War',
    'Western'
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
  validate :validate_genres

  # scope pour rechercher les films par genre @noah ?
  #scope :by_genre, ->(genre) { where("genres LIKE ?", "%#{genre}%") }

  private

  # validation des genres : vérifier que chaque genre est valide
  def validate_genres
    genre_list = genres.split(',').map(&:strip).map(&:capitalize) # On transforme les genres en liste, en supprimant les espaces et en normalisant la casse
    invalid_genres = genre_list.reject { |genre| GENRES.include?(genre) } # On filtre les genres non valides

    return unless invalid_genres.any? # Si aucun genre invalide n'est trouvé, on quitte la méthode immédiatement

    errors.add(:genres, "contient des genres non valides : #{invalid_genres.join(', ')}")
  end
end
