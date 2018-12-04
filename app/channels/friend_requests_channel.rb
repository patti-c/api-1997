class FriendRequestsChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_by(username: params[:username])
    return unless user
    stream_from `FriendRequests#{user.id}`
  end

  def unsubscribed

  end
end
