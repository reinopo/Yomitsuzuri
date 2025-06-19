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
  # def create_books_from_api_data(books_data)
  #   books_data.each do |data|
  #     # Bookが既存であればそれを使い、なければ新しく作成
  #     book = Book.find_or_initialize_by(google_id: data[:google_id])
  #     # 既存の場合はデータを更新
  #     book.assign_attributes(
  #       title: data[:title],
  #       published_date: data[:published_date],
  #       thumbnail_link: data[:thumbnail_link],
  #       description: data[:description],
  #       isbn: data[:isbn]
  #     )
  #     book.save!

  #     # Authorが既存であれば再利用、なければ新しく作成
  #     # TODO 著者が3名以上の場合、最初の2名のみ表示して残りは「他」とする
  #     data[:authors].each do |author_name|
  #       author = Author.find_or_create_by!(name: author_name)
  #       book.authors << author unless book.authors.include?(author)
  #     end
  #   end
  # end
  def create_books_from_api_data(books_data)
    books_data.each do |data|
      # book = Book.find_or_initialize_by(google_id: data[:google_id])

      # # 既存の published_date がある場合はそれを優先
      # incoming_date = data[:published_date]
      # preserved_date = book.published_date.presence || incoming_date

      # # 属性を上書き（published_dateは正規化はBookモデル側で行われる）
      # book.assign_attributes(
      #   title: data[:title],
      #   published_date: preserved_date,
      #   thumbnail_link: data[:thumbnail_link],
      #   description: data[:description],
      #   isbn: data[:isbn]
      # )
      # book.save!
      book = Book.find_or_initialize_by(google_id: data[:google_id])
      puts "📦 published_date raw from API: #{data[:published_date].inspect}"

      book.assign_attributes(
        title: data[:title],
        thumbnail_link: data[:thumbnail_link],
        description: data[:description],
        isbn: data[:isbn]
      )

      if data[:published_date].present? && book.published_date.blank?
        book.published_date = data[:published_date]
        book.published_date_will_change! # ← これがないとbefore_validationが発火しない
      end

      book.save!

      # 著者情報の保存（重複追加を防止）
      data[:authors].each do |author_name|
        author = Author.find_or_create_by!(name: author_name)
        book.authors << author unless book.authors.include?(author)
      end
    end
  end

end
