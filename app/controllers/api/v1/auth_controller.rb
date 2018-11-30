class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: user_login_params[:username])
    if @user && @user.authenticate(user_login_params[:password])

      @user.is_online
      # broadcast login status to relevant channel
      UsersChannel.broadcast_to @user, "online"

      # send token and data to frontend
      token = encode_token({ user_id: @user.id })
      render json: {
        user: UserSerializer.new(@user),
        pending_requests: @user.pending_requests,
        desired_friendships: @user.desired_friendships,
        jwt: token
      }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end
  end

  private

  def user_login_params
    params.require(:user).permit(:username, :password)
  end
end
