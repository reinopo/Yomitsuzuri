class CitationsController < ApplicationController
  def create
    @reading_log = ReadingLog.find(params[:reading_log_id])
    @citation = @reading_log.citations.build(citation_params)

    if @citation.save
      redirect_to book_path(@reading_log.book), notice: "引用を追加しました！"
    else
      redirect_to book_path(@reading_log.book), alert: "保存に失敗しました。"
    end
  end

  private

  def citation_params
    params.require(:citation).permit(:content)
  end
end
