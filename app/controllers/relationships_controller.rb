class RelationshipsController < ApplicationController
  # Deviseを使用しているなら、「if logged_in?」の代わりに次の行のコードを使用する
  # before_action :authenticate_user!
  respond_to? :js # 存在するアクションのrespondを全てjsで返す場合はこのような記述でも可能

  def create
    if logged_in?
      @user = User.find(params[:relationship][:followed_id])
      # binding.pry
      current_user.follow!(@user)
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
