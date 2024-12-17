class MoviePlaylist < ApplicationRecord
  belongs_to :movie
  belongs_to :playlist

  validates :playlist, uniqueness: { scope: :movie_id, message: " · Eh bien, on a fait le tour du bocal ? Ce film est déjà ajouté à ta playlist !" }
end
