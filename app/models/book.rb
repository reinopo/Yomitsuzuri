class Book < ApplicationRecord
  # 著者との関連
  belongs_to :author

  # 読書ログとの関連
  has_many :reading_logs, dependent: :destroy
  has_many :users, through: :reading_logs
end
