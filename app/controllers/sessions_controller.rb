class SessionsController < ApplicationController
  def new
  end

  def create
    # メールアドレスが一致するデータがなければfalseを返す
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path,notice: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      @user = User.new if current_user.blank?
      @blog = Blog.new
      # @blogs = Blog.all
      render template: 'insta_clones/index'
    end
  end

  def destroy
    # ※このuser_idに何が入っているのか、デバッグツール使って見る
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end
end
