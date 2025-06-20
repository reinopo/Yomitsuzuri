class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    books = @author.books
                  .includes(:reading_logs)
                  .where(reading_logs: { user_id: current_user.id })

    # 読了率
    @total_books = books.count
    @read_books_count = books.select { |book|
      book.reading_logs.find_by(user_id: current_user)&.reading_status == "read"
    }.count

    @read_ratio = if @total_books > 0
                    (@read_books_count.to_f / @total_books * 100).round
                  else
                    0
                  end

    # 年別表示
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

    # 各 book に対する current_user の reading_log をハッシュ形式で取得
    @reading_logs_by_book_id = current_user.reading_logs
                                            .where(book_id: books.map(&:id))
                                            .index_by(&:book_id)
  end

end
