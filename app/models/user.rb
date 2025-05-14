class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  # 読書ログとの関連
  has_many :reading_logs, dependent: :destroy
  has_many :books, through: :reading_logs

  # お気に入り著者との関連
  has_many :favorite_authors, dependent: :destroy
  has_many :authors, through: :favorite_authors
end
