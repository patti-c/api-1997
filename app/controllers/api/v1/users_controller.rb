class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.create(user_params)
    if @user.valid?
      @user.is_online
      render json: {
        user: UserSerializer.new(@user),
        pending_requests: @user.pending_requests,
        desired_friendships: @user.desired_friendships
      }, status: :created
    else
      render json: { error: 'Failed to create user.' }, status: :not_acceptable
    end
  end

  def userdata
    current_user.is_online
    UsersChannel.broadcast_to @user, "online"
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
    if(friend_request)
      render json: { message: 'Friend Request Created' }, status: :created
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
    UsersChannel.broadcast_to current_user, "offline"
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :name, :email)
  end

end
