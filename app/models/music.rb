class Music < ApplicationRecord
  include Rails.application.routes.url_helpers

  with_options presence: true do
    validates :category_id
    validates :genre_id
    validates :user
  end

  validate :music_attached

  belongs_to :user
  has_many :titles, dependent: :destroy
  has_one_attached :music

  def music_url
    music.attached? ? url_for(music) : nil
  end

  private

  def music_attached
    return if music.attached?

    errors.add(:music, 'must be attached')
  end
end
