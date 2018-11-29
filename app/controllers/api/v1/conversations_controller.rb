class Api::V1::ConversationsController < ApplicationController

  def index
    conversations = current_user.conversations
    render json: conversations
  end

  def get_conversation
    params.permit(:username)
    friend = current_user.friends.find_by(username: params[:username])

    conversation = current_user.conversations.map{|convo| convo.users.include?(friend)}

    byebug

    if conversation
      render json: { conversation: ConversationSerializer.new(conversation)}, status: :accepted
    else
      newConvo = Conversation.create()
      newConvo.users << current_user
      newConvo.users << friend
      render json: { conversation: ConversationSerializer.new(newConvo)}, status: :created
    end

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
