module Api::V1
class UserAuthenticationController < ApplicationController

    def signup
        @user = User.new(user_params)
        if @user.save
            render json: {
                status: "User is created",
                results: @user
            }
        else
            render json: {
                status: :unprocessable_entity,
                results: @user.errors.full_messages
        }
        end
    end

    #Login authentication for the credentials
    def login
        @user = User.find_by(email: login_params[:email])

        if @user && @user.authenticate(login_params[:password])
          token = encode_token({
             user_id: @user.id
        })
        render json: {
            status: :Authorized,
            token: token,
            user_id: @user.id,
            name: @user.name
        }
    else
        render json: {
            status: :Unauthorized,
            error: "Invalid email or password"
    }
        end
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

    def login_params
        params.permit(:email, :password)
    end

    def encode_token(payload)
        JWT.encode(payload,  Rails.application.credentials.secret_key_base)
    end

end
end

