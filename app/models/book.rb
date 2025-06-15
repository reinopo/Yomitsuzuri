class Book < ApplicationRecord
  validates :google_id, uniqueness: true
  
  # 著者との関連
  has_many :authorships, dependent: :destroy
  # 中間テーブルのauthorshipテーブルを通してauthorを参照
  has_many :authors, through: :authorships

  # 読書ログとの関連
  has_many :reading_logs, dependent: :destroy
  has_many :users, through: :reading_logs
end
