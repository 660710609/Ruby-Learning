class Api::V1::User::SessionsController < Api::V1::User::AppController
  skip_before_action :set_user_from_header, only: [ :sign_in ]
  before_action :find_user, only: [ :sign_in ]

  def sign_in
    # params {email , password}
    raise LgError.new("Invalid Email") rescue nil
    if !@user.nil? && @user.valid_password?(params[:user][:password])

      @user.renew_auth_token

      ActionCable.server.broadcast(
        "notifications_user_#{@user.id}",
        {
          message: "Hello !",
          user_email: @user.email,
          login_time: Time.now.strftime("%H:%M")
        }
      )
      HeartbeatNotificationJob.perform_later(@user.id)
      render json: { success: true, user: @user.as_json_with_jwt }
    else
      raise LgAuthenticationError.new("Invalid Email or Password")
    end
  end

  def sign_out
    if current_user
      current_user.update(auth_token: nil)
      render json: { success: true }
    end
  end

  def me
    render json: { success: true, user: current_user.as_profile_json }
  end


  private

  def find_user
    @user = User.find_by_email(params[:user][:email])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
