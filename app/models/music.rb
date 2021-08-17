class Music < ApplicationRecord
  with_options presence: true do
    validates :category_id
    validates :genre_id
    validates :user
  end

  validate :music_attached

  belongs_to :user
  has_one_attached :music

  private

  def music_attached
    return if music.attached?

    errors.add(:music, 'must be attached')
  end
end
