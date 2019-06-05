class ConversationsController < ApplicationController
  # Device使用時はif logged_in? ではなく下記を使う
  # before_action :authenticate_user!

  def index
    @conversations = Conversation.all
  end
  
  def create
    if logged_in?
      # if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      #   # 自分と相手の会話がある時？
      #   @conversation = Convarsation.between(params[:sender_id],params[:recipient_id]).first
      # else
      #   # 会話がまだないよ。新規作成する。
      #   @conversation = Conversation.create!(conversation_params)
      # end
      # redirect_to conversation_messages_path(@conversation)

      if Conversation.between(params[:sender_id], params[:recipient_id]).present?
        @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end
      redirect_to conversation_messages_path(@conversation)

    else
      redirect_to root_path
    end
  end

  private

  def conversation_params
    # 新規作成で自分と相手のユーザーIDを定義するよ。書き換えられたらまずいよ。
    params.permit(:sender_id,:recipient_id)
  end
end
