class ServiceShow < ApplicationRecord
  belongs_to :service
  belongs_to :movie

  validates :link, presence: true
  validates :video_link, presence: true
end
