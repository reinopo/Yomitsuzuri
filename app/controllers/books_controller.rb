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

    year_param  = params[:published_date_year]
    month_param = params[:published_date_month]

    if year_param.blank? || month_param.blank?
      flash.now[:alert] = "出版年と月は必須です。"
      render :show and return
    end

    year  = year_param.to_i
    month = month_param.to_i
    day   = (params[:published_date_day].presence || "1").to_i

    begin
      @book.published_date = Date.new(year, month, day)
    rescue ArgumentError
      flash.now[:alert] = "無効な日付です。"
      render :show and return
    end

    if @book.save
      redirect_to @book, notice: "出版年を登録しました！"
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
