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

  def added_name
    User.where(id: self.added_id)[0].username
  end

  def adder_name
    User.where(id: self.adder_id)[0].username
  end

end
