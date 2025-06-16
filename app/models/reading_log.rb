class ReadingLog < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum reading_status: { read: 0, unread: 1, stock: 2 }

  def reading_status_label
    case reading_status
    when "read"
      "既読"
    when "unread"
      "未読"
    when "stock"
      "積読"
    else
      "未設定"
    end
  end
end
