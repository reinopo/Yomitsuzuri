class ReadingLogsController < ApplicationController
  before_action :authenticate_user!

  def create
    # puts "📘 createアクション入った！"
    puts "🔍 params[:book_published_date] = #{params[:book_published_date].inspect}"
    book = nil

    ActiveRecord::Base.transaction do
      # 1. JSでフォームから送られてきた値を取得
      google_id = params[:book_google_id].to_s.strip
      comment = params[:reading_log][:comment]
      citation_param = params[:reading_log][:citation]
      status = params[:reading_log][:reading_status].to_i

    # 2. 選択された本がすでにDBにあるかを google_id を元に確認し、なければインスタンス作成
      # モーダルボタンに仕込んだdata属性から本の情報をJSが取得してhidden fieldに入れて送信。その送信された値をまとめて代入して DB に保存

      # 🔽 Bookは必ず存在する前提（search時に登録済み）
      @book = Book.find_by!(google_id: google_id)
      # # 既存の本があるかどうか確認（この1回でOK）
      # existing_book = Book.find_by(google_id: google_id)

      # # もし存在すればその本を使う（保存はしない）
      # if existing_book
      #   puts "🧪 既存のBookを使用：#{existing_book.title}"
      #   @book = existing_book
      # else
      #   puts "✅ 新規Bookを保存します"
      #   # なければ新規作成（parsed_date含めて）
      #   puts "✅"
      #   @book = Book.new(
      #     google_id: google_id,
      #     isbn: params[:book_isbn],
      #     title: params[:book_title],
      #     published_date: parsed_date,
      #     thumbnail_link: params[:book_image_url],
      #     description: params[:book_description]
      #   )
      #   @book.save!
      #   puts "✅ Book saved: #{@book.title}"

      #   puts "✅ published_date after save: #{@book.published_date.inspect}"
      # end

    # 3. 著者情報を保存
      if params[:book_authors].present?
        author_names = params[:book_authors].split(',').map(&:strip)
        author_names.each do |author_name|
          # 著者がすでに DB に存在するかを確認し、なければインスタンス作成
          author = Author.find_or_create_by!(name: author_name)
          # 著者と本の結びつきを確認し、なければ結びつきを作る
          Authorship.find_or_create_by!(author: author, book: @book)
        end
      end

      # 2人で書いた1冊の本の情報を保存する時の流れ↓
      # 1冊の本の情報をbookテーブルに追加 → 2人の著者の情報をauthorテーブルに追加 → 2つの組み合わせの情報をauthorshipテーブルに追加

      puts "🟡 ここから ReadingLog を保存"
      reading_log = current_user.reading_logs.find_or_create_by!(book: @book)

      # 読書状況とコメントは更新（すでに存在していれば更新、なければcreate時に入る）
      reading_log.update!(
        reading_status: status,
        comment: comment
      )

      # 引用メモ（複数）をcitationテーブルに追加（常に新規追加）
      reading_log.citations.create!(content: citation_param) if citation_param.present?

      # 登録成功時には、create.turbo_stream.erbの中身を実行
      flash.now[:register_success_notice] = "#{@book.title} を登録しました！"
      respond_to do |format|
        format.turbo_stream
      end
    end

  # 登録失敗時の処理
  rescue => e
    Rails.logger.error "登録エラー: #{e.message}"
    flash[:alert] = "登録に失敗しました。もう一度お試しください。"
    redirect_back(fallback_location: root_path)
  end

  def update_status
    @reading_log = current_user.reading_logs.find(params[:id])
    if @reading_log.update(reading_status: params[:reading_log][:reading_status])
      redirect_to book_path(@reading_log.book), notice: "読書状況を更新しました！"
    else
      redirect_to book_path(@reading_log.book), alert: "更新に失敗しました。"
    end
  end

  def update_comment
    @reading_log = current_user.reading_logs.find(params[:id])
    if @reading_log.update(comment: params[:reading_log][:comment])
      redirect_to book_path(@reading_log.book), notice: "コメントを更新しました！"
    else
      redirect_to book_path(@reading_log.book), alert: "更新に失敗しました"
    end
  end

  def update
  end

  def destroy
  end
end
