class UserSerializer < ActiveModel::Serializer
  attributes :username, :name, :online
  has_many :friends, through: :relationships
end
