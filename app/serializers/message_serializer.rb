class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :username
end
