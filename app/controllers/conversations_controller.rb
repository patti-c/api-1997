class ConversationsController < ApplicationController

  def index
    render json: conversations
  end

  def create
    conversation = Conversation.new(conversation_params)
    if conversation.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        ConversationSerializer.new(conversation)
      ).serializable_hash
      ActionCable.server.broadcast 'conversations_channel', serialized_data
      head :ok
    end
  end

  def conversation_params
    params.require(:conversation).permit(:user)
  end

end
