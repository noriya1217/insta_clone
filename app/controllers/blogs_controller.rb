class BlogsController < ApplicationController
  before_action :set_blog,only: [:update,:show,:destroy]
  before_action :set_user_blog,only: [:create,:confirm]

  def list
    @blogs = Blog.all
  end

  def create
    if @blog.save
      redirect_to root_path, notice: "ブログを作成しました"
    end
  end

  def update
    if @blog.update(blog_params)
      redirect_to root_path, notice: "ブログを編集しました"
    else
      set_blog
      @blogs = Blog.all
      flash.now[:danger] = 'ブログ編集に失敗しました'
      render template: 'facebook_clones/index'
    end
  end

  def confirm
    if @blog.invalid?
      @blogs = Blog.all
      favorite = current_user.favorites
      @blogs_favo = Blog.where(id: favorite.select("blog_id"))
      flash.now[:danger] = 'ブログ作成に失敗しました'
      render template: 'facebook_clones/index'
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def destroy
    @blog.destroy
    redirect_to root_path,notice: "ブログを削除しました"
  end

  private

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def set_user_blog
    @blog = current_user.blogs.build(blog_params)
  end

  def blog_params
    params.require(:blog).permit(:content,:image,:image_cache)
  end

end