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
  has_one_attached :icon_image
end
