class Room < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships

  # TODO: Add db default for role
  enum role: [:member, :moderator, :owner]
end
