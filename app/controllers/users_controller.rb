class UsersController < ApplicationController
  before_action :set_user,only:[:show,:update,:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserAccountCreateMailer.user_account_create_mail(@user).deliver
      flash[:notice] = 'アカウント作成に成功しました'
      redirect_to root_path
    else
      @blog = Blog.new
      render template: 'insta_clones/index'
    end
  end

  def update
    # binding.pry
    if @user.id != current_user.id
      different_account
    elsif @user.update(user_params)
      redirect_to user_path(current_user.id), notice: "プロフィール画像を更新しました"
    else
      redirect_to user_path(current_user.id), notice: 'プロフィール画像の更新に失敗しました'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path,notice: "ブログを削除しました"
  end

  def show
    favorite = current_user.favorites
    @blogs_favo = Blog.where(id: favorite.select("blog_id"))
    @my_blogs = Blog.where(user_id: @user.id)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,:image,:image_cache)
  end

  def different_account
    flash[:danger] = '不正なアクセスを検知しました'
    @blogs = Blog.all
    @blog = Blog.new
    favorite = current_user.favorites
    @blogs_favo = Blog.where(id: favorite.select("blog_id"))
    render template: 'insta_clones/index'
  end

end
