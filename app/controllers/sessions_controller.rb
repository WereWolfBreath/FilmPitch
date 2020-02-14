class SessionsController < ApplicationController

    def new
    end

    def create
        @user = User.find_by(username: params[:user][:username])
        if @user.try(:authenticate, params[:user][:password])
            session[:user_id] = @user.id
            redirect_to root_path
        else
            redirect_to new_user_path
        end
    end

    def destroy
        session.delete :user_id
        redirect_to new_user_path
    end

    def omniauth
        # @user = User.find_or_create_by(uid: auth[:uid]) do |u|
        #     u.username= auth[:info][:username]
        #     u.email= auth[:info][:email]
        #     u.password= SecureRandom.hex
    #end
    #session[:user_id] = @user.id
    #redirect_to user_path(@user)
        #byebug
    end

    private

    def auth
        request.env['omniauth.auth']
    end

end