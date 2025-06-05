class SearchController < ApplicationController
  def index
    if params[:q].blank?
      flash.now[:danger] = '検索ワードを入力してください'
      @google_books = []
    else
      @google_books = BookSearchService.new(params[:q]).call
      create_books_from_api_data(@google_books)
    end
  end

  private

  def create_books_from_api_data(books_data)
    books_data.each do |data|
      # Book作成 or 更新
      book = Book.find_or_initialize_by(google_id: data[:google_id])
      book.assign_attributes(
        title: data[:title],
        published_date: data[:published_date],
        thumbnail_link: data[:thumbnail_link],
        description: data[:description],
        isbn: data[:isbn]
      )
      book.save!

      # Author作成 & 紐付け
      data[:authors].each do |author_name|
        author = Author.find_or_create_by!(name: author_name)
        book.authors << author unless book.authors.include?(author)
      end
    end
  end
end
