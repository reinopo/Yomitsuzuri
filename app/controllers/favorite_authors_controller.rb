class FavoriteAuthorsController < ApplicationController
  def create
    @favorite_author = current_user.favorite_authors.create!(author_id: params[:author_id])
    redirect_to author_path(@favorite_author.author), flash: { favorite_notice: "#{@favorite_author.author.name} をお気に入りに追加しました！" }
  end

  def destroy
    favorite_author = current_user.favorite_authors.find(params[:id])
    favorite_author.destroy
    redirect_to mypage_path, flash: { reading_log_deleted_notice: "#{favorite_author.author.name}をお気に入りから削除しました。" }
  end
end
