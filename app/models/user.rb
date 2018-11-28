class User < ApplicationRecord

  # SECURITY AND VALIDATIONS

  has_secure_password
  validates :username, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: true

  # DATABASE RELATIONSHIPS

  has_many :messages, through: :conversations

  has_many :relationships, dependent: :destroy
  has_many :friends, through: :relationships
  has_many :conversations, through: :friends

  # METHODS

  def add_friend(new_friend)
    if User.find(new_friend.id)
      FriendRequest.create(adder_id: self.id, added_id: new_friend.id)
    end
  end

  def pending_requests
    FriendRequest.where(added_id: self.id).map{|request| request.adder_name}
  end

  def desired_friendships
    FriendRequest.where(adder_id: self.id).map{|request| request.added_name}
  end

end
