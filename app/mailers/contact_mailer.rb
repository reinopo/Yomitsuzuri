class ContactMailer < ApplicationMailer
  default to: 'khf_5@icloud.com'

  def notify_admin
    @name = params[:name]
    @email = params[:email]
    @message = params[:message]

    mail(
      from: params[:email],
      subject: "【Yomitsuzuri】お問い合わせが届きました"
    )
  end
end
