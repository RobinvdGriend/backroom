class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :title, presence: true, length: { in: 3..120 }
  validates :body 
  validates :user_id, presence:true
  validates :room_id, presence:true
end
