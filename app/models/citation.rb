class Citation < ApplicationRecord
  belongs_to :reading_log

  validates :content, presence: true, length: { maximum: 1000 }
end
