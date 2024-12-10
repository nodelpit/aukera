class Playlist < ApplicationRecord
  belongs_to :user

  has_many :movie_playlists
  has_many :movies, through: :movie_playlists

  validates :name, presence: true
end
