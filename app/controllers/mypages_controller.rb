class MypagesController < ApplicationController
  layout "mypage"
  
  def show
    redirect_to mypage_home_path
  end

  def home
  end

  def favorites
  end

  def citations
  end
end
