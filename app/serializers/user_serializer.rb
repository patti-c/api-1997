class UserSerializer < ActiveModel::Serializer
  attributes :username, :name, :online, :muted, :hidden
  has_many :friends, through: :relationships
end
