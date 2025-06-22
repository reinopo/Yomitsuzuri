class CitationsController < ApplicationController
  def create
    @reading_log = ReadingLog.find(params[:reading_log_id])
    @citation = @reading_log.citations.build(citation_params)

    if @citation.save
      redirect_to book_path(@reading_log.book), flash: { reading_log_notice: "引用を追加しました！" }
    else
      redirect_to book_path(@reading_log.book), flash: { reading_log_alert: "保存に失敗しました。" }
    end
  end

  def destroy
    reading_log = ReadingLog.find(params[:reading_log_id])
    citation = reading_log.citations.find(params[:id])
    citation.destroy
    redirect_to book_path(reading_log.book), flash: { reading_log_notice: "引用を削除しました。" }
  end

  private

  def citation_params
    params.require(:citation).permit(:content, :page_number)
  end
end
