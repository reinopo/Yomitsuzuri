class SearchController < ApplicationController
  # ビューからリクエストを受け取り、空文字ならエラーを返し、そうでなければBookSearchServiceを呼び出す
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

  # BookSearchServiceが返した本の情報をDBに保存
  def create_books_from_api_data(books_data)
    books_data.each do |data|
      # Bookが既存であればそれを使い、なければ新しく作成
      book = Book.find_or_initialize_by(google_id: data[:google_id])
      # 既存の場合はデータを更新
      book.assign_attributes(
        title: data[:title],
        published_date: data[:published_date],
        thumbnail_link: data[:thumbnail_link],
        description: data[:description],
        isbn: data[:isbn]
      )
      book.save!

      # Authorが既存であれば再利用、なければ新しく作成
      # TODO 著者が3名以上の場合、最初の2名のみ表示して残りは「他」とする
      data[:authors].each do |author_name|
        author = Author.find_or_create_by!(name: author_name)
        book.authors << author unless book.authors.include?(author)
      end
    end
  end
end
