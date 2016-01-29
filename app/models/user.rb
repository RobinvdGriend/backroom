class User < ActiveRecord::Base
  has_many :memberships
  has_many :rooms, through: :memberships
  has_many :posts

  # TODO: Add more elegant email validation
  validates :name, presence: true, length: { in: 3..21 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true

  has_secure_password

  def self.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    return BCrypt::Password.create(password, cost: cost)
  end

  def is_room_member?(room)
    room.memberships.where(user_id: self.id).any?
  end

  def is_room_moderator?(room)
    self.is_room_member?(room) && room.memberships.find_by(user_id: self.id).role == "moderator"
  end
end
