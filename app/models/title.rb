class Title < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :color, format: { with: /\A#[A-Fa-f\d]{6}\z/, message: 'must be a color format of #aaaaaa' }
    validates :user, uniqueness: { scope: :music_id }
    validates :music
  end

  belongs_to :user
  belongs_to :music
  has_many :comments
end
