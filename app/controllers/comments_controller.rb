class CommentsController < ApplicationController
  # コメントを保存、投稿するアクション
  def create
    # Blogをパラメータの値から探し出し、Blogに紐づくcommentsとしてbuildする。
    @blog = Blog.find(params[:blog_id])
    # @blog(1) < comments(n) build = 作成 (params渡された値から blog_id と content)
    @comment = @blog.comments.build(comment_params)

    #クライアント要求に応じてフォーマット変更
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@blog),notice:'投稿できませんでした＼(^o^)／' }
      end
    end

  end

  private

  def comment_params
    # name = comment[blog_id]とcomment[content]を許可する
    params.require(:comment).permit(:blog_id,:content)
  end
end
