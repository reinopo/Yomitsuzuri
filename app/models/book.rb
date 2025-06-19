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

  # @book.save! が別のとこで走っても、既存の出版年を nil に上書きしない
  before_update :protect_published_date

  # published_date の setter をオーバーライド
  def published_date=(value)
    Rails.logger.debug "📥 setter called with: #{value.inspect} (#{value.class})"

    if value.is_a?(String)
      normalized = case value
                  when /^\d{4}$/ then "#{value}-01-01"
                  when /^\d{4}-\d{2}$/ then "#{value}-01"
                  else value
                  end

      begin
        super(Date.parse(normalized)) # StringをDateに変換して保存
      rescue ArgumentError
        Rails.logger.warn "⚠️ setter: 日付のパース失敗 → nil"
        super(nil)
      end
    else
      super(value) # すでに Date 型などの場合はそのまま
    end
  end

  private

  # 保存済みのpublished_dateがある場合、それを消さないように保護
  def protect_published_date
    if published_date_changed? && published_date_was.present? && published_date.blank?
      self.published_date = published_date_was
    end
  end
end
