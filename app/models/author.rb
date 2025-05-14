class Author < ApplicationRecord
  # 本との関連
  has_many :books

  # お気に入りユーザーとの関連
  has_many :favorite_authors, dependent: :destroy
  has_many :users, through: :favorite_authors
end
