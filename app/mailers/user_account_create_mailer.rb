class UserAccountCreateMailer < ApplicationMailer
  def user_account_create_mail(account_create)
    @account_create = account_create
    # アカウント作成者に送りたいので、メールアドレスをtoに持ってきたい
    mail to:"noriya.saeki@gmail.com",subject:"アカウント作成確認メール"
  end
end
