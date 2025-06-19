class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
    books = @author.books.includes(:reading_logs).where(reading_logs: { user_id: current_user.id })

    books_with_date = books.where.not(published_date: nil)
                          .order(published_date: :desc)

    @books_with_year = books_with_date.group_by { |book| book.published_date.year }

    @books_without_year = books.where(published_date: nil).order(created_at: :desc)
  end
end
