class BlogCreateMailer < ApplicationMailer
  def blog_create_mail(blog_create)
    @blog_create = blog_create
    # アカウント作成者に送りたいので、メールアドレスをtoに持ってきたい
    # binding.pry
    mail to:"#{@blog_create.user.email}",subject:"新規投稿確認メール"
  end
end
