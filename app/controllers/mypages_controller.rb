class MypagesController < ApplicationController
  layout "mypage"
  
  def show
    redirect_to mypage_home_path
  end

  def home
    @reading_logs = current_user.reading_logs.includes(:book)
  end

  def favorites
  end

  def citations
  end
end
