class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :user
end
