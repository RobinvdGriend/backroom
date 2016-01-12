class User < ActiveRecord::Base
  has_many :memberships
  has_many :rooms, through: :memberships

  validates :name, presence: true, length: { in: 3..21 }, uniqueness: true

  has_secure_password

  def self.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    return BCrypt::Password.create(password, cost: cost)
  end
end
