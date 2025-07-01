class Author < ApplicationRecord
  # 本との関連
  has_many :authorships, dependent: :destroy
  has_many :books, through: :authorships

  # お気に入り著者との関連
  has_many :favorite_authors, dependent: :destroy
  has_many :users, through: :favorite_authors
end