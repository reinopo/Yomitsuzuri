class MypagesController < ApplicationController
  layout "mypage"
  
  def show
    redirect_to home_mypage_path
  end

  def home
    # reading_logを作成した日が新しい順に表示
    @reading_logs = current_user.reading_logs.includes(book: :authors).order(created_at: :desc)
  end

  def favorites
    sort = params[:sort]

    @favorite_authors = current_user.favorite_authors.includes(:author)

    @favorite_authors = case sort
                      when "name"
                        @favorite_authors.sort_by { |fa| fa.author.name }
                      when "recent"
                        @favorite_authors.order(created_at: :desc)
                      when "old"
                        @favorite_authors.order(created_at: :asc)
                      else
                        @favorite_authors.order(:id) # デフォルト
                      end
  end


  def citations
    @citations = current_user.reading_logs.includes(:book, :citations)
                      .flat_map(&:citations)
                      .sort_by(&:created_at).reverse
  end
end
