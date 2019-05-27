class FacebookClonesController < ApplicationController
  def index
    if params[:back]
      @blog = Blog.new(blog_params)
      # binding.pry
    else
      @blog = Blog.new
    end

    if current_user.present?
      favorite = current_user.favorites
      @blogs_favo = Blog.where(id: favorite.select("blog_id"))
      # binding.pry
    end

    @user = User.new if current_user.blank?
    @blogs = Blog.all
  end

  private

  def blog_params
    params.require(:blog).permit(:content,:image,:image_cache)
  end
end
