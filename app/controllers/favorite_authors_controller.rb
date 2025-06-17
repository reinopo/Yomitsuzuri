class FavoriteAuthorsController < ApplicationController
  def create
    @favorite_author = current_user.favorite_authors.create!(author_id: params[:author_id])
    redirect_to author_path(@favorite_author.author), notice: "#{@favorite_author.author.name} をお気に入りに追加しました！"
  end

  def destroy
  end
end
