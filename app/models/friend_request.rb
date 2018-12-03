class FriendRequest < ApplicationRecord
  belongs_to :added, class_name: "User"
  belongs_to :adder, class_name: "User"
  validates :adder, presence: true
  validates :added, presence: true

  def accept
    relationship = Relationship.create(user: added, friend: adder)
    destroy
    return relationship
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
