class FriendRequest < ApplicationRecord
  belongs_to :added, class_name: "User"
  belongs_to :adder, class_name: "User"

  def accept
    added.friends << friend
    destroy
  end

end
