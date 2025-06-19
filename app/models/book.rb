class Book < ApplicationRecord
  validates :google_id, uniqueness: true
  validates :published_date, presence: false
  
  # 著者との関連
  has_many :authorships, dependent: :destroy
  # 中間テーブルのauthorshipテーブルを通してauthorを参照
  has_many :authors, through: :authorships

  # 読書ログとの関連
  has_many :reading_logs, dependent: :destroy
  has_many :users, through: :reading_logs

  # 保存前にpublished_dateを整形
  before_validation :normalize_published_date

  # @book.save! が別のとこで走っても、既存の出版年を nil に上書きしない
  before_update :protect_published_date

  private

  # def normalize_published_date
  #   return if published_date.blank?

  #   # デバッグログを追加
  #   Rails.logger.debug "📆 raw published_date before normalize: #{published_date.inspect}"

  #   if published_date.is_a?(String)
  #     normalized_date = case published_date
  #                       when /^\d{4}$/
  #                         "#{published_date}-01-01"
  #                       when /^\d{4}-\d{2}$/
  #                         "#{published_date}-01"
  #                       else
  #                         published_date
  #                       end

  #     begin
  #       self.published_date = Date.parse(normalized_date)
  #       Rails.logger.debug "📆 parsed and normalized to: #{published_date}"
  #     rescue ArgumentError
  #       Rails.logger.warn "⚠️  Could not parse published_date: #{normalized_date.inspect}"
  #       self.published_date = nil
  #     end
  #   end
  # end


def normalize_published_date
  puts "🐛 コールバック normalize_published_date 発動！"
  return if published_date.blank?

  if published_date.is_a?(String)
    normalized_date = case published_date
                      when /^\d{4}$/
                        "#{published_date}-01-01"
                      when /^\d{4}-\d{2}$/
                        "#{published_date}-01"
                      else
                        published_date
                      end

    begin
      self.published_date = Date.parse(normalized_date)
      puts "📅 正規化結果: #{self.published_date.inspect}"
    rescue ArgumentError
      puts "⚠️ 日付パース失敗: #{normalized_date.inspect}"
      self.published_date = nil
    end
  end
end




  # 保存済みのpublished_dateがある場合、それを消さないように保護
  def protect_published_date
    if published_date_changed? && published_date_was.present? && published_date.blank?
      self.published_date = published_date_was
    end
  end
end
