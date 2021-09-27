# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  with_options presence: true do
    validates :nickname, uniqueness: true
    validates :icon_color, format: { with: /\A#[A-Fa-f\d]{6}\z/, message: 'must be a color format of #aaaaaa' }
  end

  # passwordにバリデーションかけるとログインした時にauthenticate tokenを返してくれなくなる（原因不明）
  # 自分でvalidate実装しても不可
  # validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'must contain alphabets and numbers' }

  has_many :musics
  has_many :titles
  has_many :comments
  has_many :follows
  has_many :followings, through: :follows, source: :following
  has_many :reverse_of_follows, class_name: 'Follow', foreign_key: 'following_id'
  has_many :followers, through: :reverse_of_follows, source: :user

  def new_follow(following_user_id)
    self.follows.new(following_id: following_user_id)
  end

  def find_follow(following_user_id)
    self.follows.find_by(following_id: following_user_id)
  end

  def count_follows
    {
      followings: self.followings.count,
      followers: self.followers.count
    }
  end

  def following?(following_user)
    self.followings.include?(following_user)
  end

  def followings_list
    self.followings.select('users.id', 'users.nickname', 'users.icon_color')
  end

  def followers_list
    self.followers.select('users.id', 'users.nickname', 'users.icon_color')
  end
end
