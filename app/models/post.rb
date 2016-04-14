class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  validates :title, presence: true, length: { in: 3..120 }
  validates :user_id, presence:true
  validates :room_id, presence:true

  def self.latest(count)
    self.order(created_at: :desc).limit(count)
  end

  def is_secret?(user)
    !self.room.is_member?(user)
  end
end
