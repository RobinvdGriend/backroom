class Room < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { in: 3..50 }
end
