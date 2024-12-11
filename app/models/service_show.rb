class ServiceShow < ApplicationRecord
  belongs_to :service
  belongs_to :movie

  validates :link, presence: true
  validates :video_link, presence: true
  validates :movie_id, uniqueness: { scope: :service_id }
end
