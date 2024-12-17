class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :service, optional: true
  has_many :playlists, dependent: :destroy
  has_one_attached :avatar
  delegate :movies, to: :playlists

  after_create :attached_defaut_avatar

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :age, numericality: { only_integer: true }

  def attached_defaut_avatar
    return if avatar.attached?

    default_avatar = Rails.root.join("app/assets/images/default-avatar.png")
    avatar.attach(io:File.open(default_avatar), filename: File.basename(default_avatar), content_type:"iamge/png")
  end
end
