class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      @user.update(online: true)
      render json: {
        user: UserSerializer.new(@user),
        pending_requests: @user.pending_requests,
        desired_friendships: @user.desired_friendships,
        jwt: token
      }, status: :created
    else
      render json: { error: 'Failed to create user.' }, status: :not_acceptable
    end
  end

  def userdata

    if(!current_user.hidden)
      current_user.is_online
      UsersChannel.broadcast_to @user, "online"
    end

    render json: {
      user: UserSerializer.new(current_user),
      pending_requests: current_user.pending_requests,
      desired_friendships: current_user.desired_friendships
    }, status: :accepted
  end

  def send_friend_request
    params.permit(:adder, :added)
    adder = User.find_by(username: params[:adder])
    added = User.find_by(username: params[:added])
    friend_request = FriendRequest.find_or_create_by(adder: adder, added: added)
    if(friend_request.valid?)
      ActionCable.server.broadcast `FriendRequests#{added.id}`, `#{adder} added you`
      render json: { message: 'Friend Request Sent' }, status: :created
    else
      render json: { message: 'Friend Request Failed' }, status: :unacceptable
    end
  end

  def accept_friend_request
    params.permit(:adder, :added)
    adder = User.find_by(username: params[:adder])
    added = User.find_by(username: params[:added])
    friend_request = FriendRequest.find_by(adder: adder, added: added)
    if(friend_request)
      relationship = friend_request.accept
      render json: { message: 'Friend Request Created' }, status: :created
    else
      render json: { message: 'Friend Request Failed' }, status: :unacceptable
    end
  end

  def deny_friend_request
    params.permit(:adder, :added)
    adder = User.find_by(username: params[:adder])
    added = User.find_by(username: params[:added])
    friend_request = FriendRequest.find_by(adder: adder, added: added)
    if(friend_request)
      friend_request.deny
      render json: { message: 'Friend Request Denied' }, status: :accepted
    else
      render json: { message: 'Unacceptable request' }, status: :unacceptable
    end
  end

  def logout
    current_user.is_offline
    if (!current_user.hidden)
      UsersChannel.broadcast_to current_user, "offline"
    end
    render json: { message: 'Logged out' }, status: :accepted
  end

  def hide
    current_user.update(hidden: true)
    UsersChannel.broadcast_to current_user, "offline"
    render json: { message: 'Usere hidden' }, status: :accepted
  end

  def unhide
    current_user.update(hidden: false)
    UsersChannel.broadcast_to current_user, "online"
    render json: { message: 'User visible' }, status: :accepted
  end


  def mute
    current_user.update(muted: true)
    render json: { message: 'Muted' }, status: :accepted
  end

  def unmute
    current_user.update(muted: false)
    render json: { message: 'Unmuted' }, status: :accepted
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :name, :email)
  end

end
