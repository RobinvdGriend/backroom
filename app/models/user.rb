class User < ActiveRecord::Base
  has_many :memberships
  has_many :rooms, through: :memberships

  # TODO: Add db constraint for email uniqueness
  # TODO: Add more elegant email validation
  validates :name, presence: true, length: { in: 3..21 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true

  has_secure_password

  def self.digest(password)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    return BCrypt::Password.create(password, cost: cost)
  end
end
