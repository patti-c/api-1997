class Conversation < ApplicationRecord
  belongs_to :relationship
  has_many :messages
end
