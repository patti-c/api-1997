class FriendRequest < ApplicationRecord
  belongs_to :added, class_name: "User"
  belongs_to :adder, class_name: "User"

  def accept
    Relationship.create(user: added, friend: adder)
    destroy
  end

  def deny
    destroy
  end

end
