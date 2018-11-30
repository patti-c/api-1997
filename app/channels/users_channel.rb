class UsersChannel < ApplicationCable::Channel
  def subscribed
    user = user.find_by(params[:username])
    return unless user
    stream_for user
  end

  def unsubscribed
    user = user.find_by(params[:username])
    return unless user
    stream_for user
  end
end
