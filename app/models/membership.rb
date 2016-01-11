class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :room

  enum role: [:member, :moderator, :owner]
end
