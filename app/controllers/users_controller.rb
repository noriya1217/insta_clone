class UsersController < ApplicationController
  before_action :set_user,only:[:show]

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
      render template: 'facebook_clones/index'
    end
  end

  def show
    favorite = current_user.favorites
    @blogs_favo = Blog.where(id: favorite.select("blog_id"))
    @my_blogs = Blog.where(user_id: current_user.id)

    if @user.id != current_user.id
      flash[:danger] = '不正なアクセスを検知しました'
      @blogs = Blog.all
      @blog = Blog.new
      render template: 'facebook_clones/index'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
