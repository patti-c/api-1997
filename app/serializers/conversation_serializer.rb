class ConversationSerializer < ActiveModel::Serializer
  attributes :id
  has_many :messages, serializer: MessageSerializer
end
