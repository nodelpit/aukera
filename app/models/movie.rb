class Movie < ApplicationRecord
  GENRES = {
    'Action' => { name: 'Action', icon: 'fas fa-fist-raised' },
    'Adventure' => { name: 'Aventure', icon: 'fas fa-hiking' },
    'Animation' => { name: 'Animation', icon: 'fas fa-film' },
    'Comedy' => { name: 'Comédie', icon: 'fas fa-laugh' },
    'Crime' => { name: 'Crime', icon: 'fas fa-user-secret' },
    'Documentary' => { name: 'Documentaire', icon: 'fas fa-book-open' },
    'Drama' => { name: 'Drame', icon: 'fas fa-theater-masks' },
    'Family' => { name: 'Famille', icon: 'fas fa-home' },
    'Fantasy' => { name: 'Fantastique', icon: 'fas fa-hat-wizard' },
    'History' => { name: 'Histoire', icon: 'fas fa-landmark' },
    'Horror' => { name: 'Horreur', icon: 'fas fa-ghost' },
    'Music' => { name: 'Musique', icon: 'fas fa-music' },
    'Mystery' => { name: 'Mystère', icon: 'fas fa-magnifying-glass' },
    'News' => { name: 'Actualités', icon: 'fas fa-newspaper' },
    'Non spécifié' => { name: 'Non spécifié', icon: 'fas fa-question' },
    'Reality' => { name: 'Télé-réalité', icon: 'fas fa-tv' },
    'Romance' => { name: 'Romance', icon: 'fas fa-heart' },
    'Science fiction' => { name: 'Science-fiction', icon: 'fas fa-robot' },
    'Talk show' => { name: 'Talk-show', icon: 'fas fa-comments' },
    'Thriller' => { name: 'Thriller', icon: 'fas fa-skull-crossbones' },
    'War' => { name: 'Guerre', icon: 'fas fa-person-rifle' },
    'Western' => { name: 'Western', icon: 'fas fa-hat-cowboy' }
  }


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

  def translated_genres
    genres_list = genres.split(',').map(&:strip)
    genres_list.map { |genre| GENRES[genre] || genre }.join(', ')
  end

  private

  # validation des genres : vérifier que chaque genre est valide
  def validate_genres
    genre_list = genres.split(',').map(&:strip).map(&:capitalize) # On transforme les genres en liste, en supprimant les espaces et en normalisant la casse
    invalid_genres = genre_list.reject { |genre| GENRES.include?(genre) } # On filtre les genres non valides

    return unless invalid_genres.any? # Si aucun genre invalide n'est trouvé, on quitte la méthode immédiatement

    errors.add(:genres, "contient des genres non valides : #{invalid_genres.join(', ')}")
  end
end
