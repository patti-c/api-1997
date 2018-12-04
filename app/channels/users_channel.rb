class UsersChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_by(username: params[:username])
    return unless user
    stream_for user
  end

  def unsubscribed
    
  end
end
