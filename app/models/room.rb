class Room < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts, dependent: :destroy
end
