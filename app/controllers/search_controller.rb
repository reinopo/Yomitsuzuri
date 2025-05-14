class SearchController < ApplicationController
  def index
    if params[:q].blank?
      flash.now[:danger] = '検索ワードを入力してください'
      @book = []
    else
      @google_books = BookSearchService.new(params[:q]).call
    end
  end
end
