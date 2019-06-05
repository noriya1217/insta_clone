class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id
  # m=月,d=日,y=西暦下二桁 l=12時間制の時,M=分,p=AM/PM
  def message_time
    # strftime( at )は何をしている？後でrails cやbinding.pryで確認
    created_at.strftime("%m/%d/%y at %l:%M %p")
    # binding.pry
  end
end
