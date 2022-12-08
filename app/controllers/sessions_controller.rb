class SessionsController < ApplicationController
    # create a user and store the info in the session
    def create
        user = User.find_by(username: params[:username])
        if user&.authenticate(params[:password])
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { error: "Invalid username or password" }, status: :unauthorized
        end
    end

    # DELETE user session via id
    def destroy
        session.delete :user_id
        head :no_content
    end
end