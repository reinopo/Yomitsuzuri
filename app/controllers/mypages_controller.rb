class MypagesController < ApplicationController
  layout "mypage"
  
  def show
    redirect_to mypage_home_path
  end

  def home
    # reading_logを作成した日が新しい順に表示
    @reading_logs = current_user.reading_logs.includes(book: :authors).order(created_at: :desc)
  end

  def favorites
  end

  def citations
  end
end
