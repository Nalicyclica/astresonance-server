class Comment < ApplicationRecord
  with_options presence: true do
    validates :text
    validates :user
    validates :title
  end
  belongs_to :user
  belongs_to :title
end
