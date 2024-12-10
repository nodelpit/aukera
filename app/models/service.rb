class Service < ApplicationRecord
  has_many :service_shows
  has_many :movies, through: :service_shows

  validates :service, presence: true
end
