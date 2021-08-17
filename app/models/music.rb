class Music < ApplicationRecord
  with_options presence: true do
    validates :category_id
    validates :genre_id
    validates :user
  end

  belongs_to :user
  has_one_attached :music
end
