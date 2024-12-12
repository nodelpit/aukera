class ServiceShow < ApplicationRecord
  belongs_to :service
  belongs_to :movie

  validates :link, presence: true
  # validates :access_type, presence: true
  validates :movie_id, uniqueness: { scope: :service_id }
  validates :service_id, presence: true
end
