class UserSerializer < ActiveModel::Serializer
  attributes :username, :name
  has_many :friends, through: :relationships
end
