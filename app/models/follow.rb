class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :following, class_name: 'User'

  validates :user, uniqueness: {scope: :following_id}
  validate :self_follow_denied

  private

  def self_follow_denied
    return if user_id != following_id

    errors.add(:user, "can't follow yourself.")
  end
end
