class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    books = @author.books.includes(:reading_logs).where(reading_logs: { user_id: current_user.id })

    books_with_date = books.select { |b| b.published_date.present? }

    # 日付変換できるものだけに絞り、日付で並べる
    sorted_books = books_with_date.sort_by do |book|
      begin
        Date.parse(book.published_date)
      rescue ArgumentError
        nil
      end
    end.reverse

    # 年ごとにグループ化
    @books_with_year = sorted_books.group_by do |book|
      begin
        Date.parse(book.published_date).year
      rescue ArgumentError
        "不明"
      end
    end

    @books_without_year = books.reject { |b| b.published_date.present? }.sort_by(&:created_at).reverse
  end

end
