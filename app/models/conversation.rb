class Conversation < ApplicationRecord
  #会話はUserの概念をsenderとrecipientに分けた形でアソシエーションする
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  # １つの会話はメセージをたくさん含む 一対多。会話履歴がなくなれば、それに付随するメッセージ群も消える
  has_many :messages, dependent: :destroy

  # sender_idとrecipient_idが同じ組み合わせで保存されないようにする
  validates_uniqueness_of :sender_id, scope: :recipient_id
  
  # =?は存在していたらtrueを返す。
  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
  end

  # 会話の相手の情報を取得する
  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
    binding.pry
  end
end
