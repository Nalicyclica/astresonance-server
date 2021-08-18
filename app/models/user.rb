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

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'must contain alphabets and numbers'

  has_many :musics
  has_many :titles
  has_many :comments
end
