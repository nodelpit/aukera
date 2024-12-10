class MoviePlaylist < ApplicationRecord
  belongs_to :movie
  belongs_to :playlist
end
