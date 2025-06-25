require 'ostruct'

class ContactsController < ApplicationController
  def new
    @contact = OpenStruct.new(name: "", email: "", message: "")
  end


  def create
    name = params[:contact][:name]
    email = params[:contact][:email]
    message = params[:contact][:message]

    if name.present? && email.present? && message.present?
      ContactMailer.with(name:, email:, message:).notify_admin.deliver_now
      redirect_to contact_path, notice: "お問い合わせを送信しました。"
    else
      flash.now[:alert] = "全ての項目を入力してください。"
      @contact = OpenStruct.new(name:, email:, message:)
      render :new, status: :unprocessable_entity
    end
  end
end
