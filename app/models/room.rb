class Room < ActiveRecord::Base
  # TODO: Add description attribute

  has_many :memberships
  has_many :users, through: :memberships
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { in: 3..50 }

  def add_user(user, options = {})
    role = options.fetch(:role, :member)

    self.memberships.create(room_id: self.id, user_id: user.id, role: Membership.roles[role])
  end

  def update_role(args)
    user = args[:user]
    role = args[:role]

    self.memberships.find_by(user_id: user.id).update(role: role)
  end

  def is_member?(user)
    user && memberships.where(user_id: user.id).any?
  end

  def is_moderator?(user)
    is_member?(user) && memberships.find_by(user_id: user.id).role == "moderator"
  end
end
