class ReadingLog < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :citations, dependent: :destroy

  enum reading_status: { read: 0, unread: 1, stacked: 2 }

  def reading_status_label
    case reading_status
    when "read"
      "既読"
    when "unread"
      "未読"
    when "stacked"
      "積読"
    else
      "未設定"
    end
  end
end
