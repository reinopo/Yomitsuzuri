class CustomDeviseMailer < Devise::Mailer
  default from: 'no-reply@yomitsuzuri.dev'

  # パスワード再設定メールのタイトル変更
  def reset_password_instructions(record, token, opts = {})
    opts[:subject] = '【読綴 -Yomitsuzuri-】パスワード再設定'
    super
  end

  # パスワード変更完了メールのタイトル変更
  def password_change(record, opts = {})
    opts[:subject] = '【読綴 -Yomitsuzuri-】パスワード変更完了'
    super
  end
end