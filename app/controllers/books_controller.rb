class BooksController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
    @reading_log = current_user.reading_logs.find_by(book_id: @book.id)
    @book.published_date = Date.parse(@book.published_date) if @book.published_date.is_a?(String)

  end

  def update
  @book = Book.find(params[:id])

  year  = params[:published_date_year].presence&.to_i
  month = params[:published_date_month].presence&.to_i

  if year.zero? || month.zero?
    flash.now[:alert] = "出版年と月は必須です。"
    render :show and return
  end

  day = (params[:published_date_day].presence || "1").to_i
  @book.published_date = Date.new(year, month, day)

  if @book.save
    redirect_to @book, notice: "出版年を更新しました！"
  else
    render :edit
  end
end

  private

  def book_params
    permitted = params.require(:book).permit(:published_date)
    Rails.logger.debug("📦 book_params: #{permitted.inspect}")
    permitted
  end

end
