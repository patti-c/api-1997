class Api::V1::MessagesController < ApplicationController

  def create
    params.permit(:text, :conversationId, :message, :user)
    byebug
    message = Message.new(text: params[:text], conversation_id: params[:conversationId], username: params[:user])
    conversation = Conversation.find_or_create_by(id: params[:conversationId])
    if message.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        MessageSerializer.new(message)
      ).serializable_hash
      MessagesChannel.broadcast_to conversation, serialized_data
      head :ok
    end
  end

  private

  # def message_params
  #   params.require(:message).permit(:text, :conversation_id, :user_id)
  # end

end
