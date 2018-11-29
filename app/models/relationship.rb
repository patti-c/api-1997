class Relationship < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship
  belongs_to :user
  belongs_to :friend, class_name: "User"

  private

  def create_inverse_relationship
    if(!friend.friends.include?(user))
      friend.relationships.create(friend: user)
    end
  end

  def destroy_inverse_relationship
    relationship = friend.relationships.find_by(friend: user)
    relationship.destroy if relationship
  end

end
