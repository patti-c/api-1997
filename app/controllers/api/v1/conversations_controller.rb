class Api::V1::ConversationsController < ApplicationController

  def index
    conversations = current_user.conversations
    render json: conversations
  end

  def get_conversation
    params.permit(:username)
    friend = current_user.friends.find_by(username: params[:username])
    relationship = current_user.relationships.find_by(friend_id: friend.id)
    conversation = Conversation.find_or_create_by(relationship_id: relationship.id)
    render json: conversation
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

  private

  def conversation_params
    params.require(:conversation).permit(:username, :friend_username)
  end

end
