class User < ActiveRecord::Base
  has_many :memberships
  has_many :rooms, through: :memberships

  validates :name, presence: true, length: { in: 3..21 }, uniqueness: true
end
