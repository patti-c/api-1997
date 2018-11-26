class Message < ApplicationRecord
  belongs_to :conversation
  validates :text, presence: true, length: {minimum: 1, maximum: 1000}
end
