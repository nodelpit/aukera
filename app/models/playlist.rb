class Playlist < ApplicationRecord
  belongs_to :user

  has_many :movie_playlists, dependent: :destroy
  has_many :movies, through: :movie_playlists
  has_one_attached :photo

  scope :by_recently_updated, -> { order(updated_at: :desc) }

  validates :name, presence: true
  validates :name, length: { maximum: 24, too_long: "Ça dépend ça dépasse. Déso, 24 caractères max !" }
end
