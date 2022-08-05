# frozen_string_literal: true

class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]

  validates :first_name, :last_name, presence: true

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize: '70x70!').processed.key
    else
      '/default.jpg'
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default.jpg'
          )
        ),
        filename: 'default.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
