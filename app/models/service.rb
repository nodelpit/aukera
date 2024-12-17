class Service < ApplicationRecord
  has_many :service_shows
  has_many :movies, through: :service_shows
  has_many :user_services
  has_many :users, through: :user_services

  validates :service, presence: true
  # validates :service_logo_link, presence: true
end
