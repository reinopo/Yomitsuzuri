class ReadingLogsController < ApplicationController
  before_action :authenticate_user!

  def create
    puts "📘 createアクション入った！"
    book = nil

    ActiveRecord::Base.transaction do
      # 1. JSでフォームから送られてきた値を取得
      isbn = params[:isbn]
      comment = params[:reading_log][:comment]
      citation = params[:reading_log][:citation]
      status = params[:reading_log][:reading_status]

    # 2. 選択された本がすでにDBにあるかを isbn を元に確認し、なければインスタンス作成
      @book = Book.find_or_initialize_by(isbn: isbn)

      # 選択された本が DB にない場合
      unless @book.persisted?
        # モーダルボタンに仕込んだdata属性から本の情報をJSが取得してhidden fieldに入れて送信。その送信された値をまとめて代入して DB に保存
        @book.assign_attributes(
          title: params[:book_title],
          published_date: params[:book_published_date],
          thumbnail_link: params[:book_image_url],
          google_id: params[:book_google_id],
          description: params[:book_description]
        )
        @book.save!
      end

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

    # 4. ユーザーに紐づいた ReadingLog を作成
      reading_log = current_user.reading_logs.find_or_initialize_by(book: @book)
      reading_log.assign_attributes(
        reading_status: status,
        comment: comment,
        citation: citation
      )
      reading_log.save!

      # 登録成功時には、create.turbo_stream.erbの中身を実行
      flash[:register_success_notice] = "#{@book.title} を登録しました！"
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

  def update
  end

  def destroy
  end
end
