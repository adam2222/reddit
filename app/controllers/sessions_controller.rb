class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    # Log in existing user
    @user = User.find_by_credentials(submitted_params[:username], submitted_params[:password] )

    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Wrong credentials"]
      render :new
    end
  end

  def destroy
    logout
    render :new
  end

  private

  def submitted_params
    params.require(:user).permit(:username, :password)
  end

end
