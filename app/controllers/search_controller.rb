class SearchController < ApplicationController
  def index
    if params[:q].blank?
      flash.now[:danger] = '検索ワードが入力されていません'
      return
    else
      @google_books = BookSearchService.new(params[:q]).call
    # if params[:q].present?
    #   @books = BookSearchService.new(params[:q]).call
    # else
    #   @books = []
    end
  end
end
