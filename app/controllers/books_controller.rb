class BooksController < ApplicationController
  def index
  end

  def show
    @book = Book.find(params[:id])
    @reading_log = current_user.reading_logs.find_by(book_id: @book.id)
  end
end
