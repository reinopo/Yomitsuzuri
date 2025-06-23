class User < ApplicationRecord
  has_one_attached :avatar
  
  validates :nickname, presence: true
  validates :email, uniqueness: true
  validate :avatar_format

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

  private

  def avatar_format
    return unless avatar.attached?
    unless avatar.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:avatar, "はJPEGまたはPNG形式でアップロードしてください")
    end
  end
end
