class UsersController < ApplicationController

  def new
    render :new
  end

  def index

    render :index
  end

  def create
    # Create new user
    user = User.new(submitted_params)
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
  end

  private

  def submitted_params
    params.require(:user).permit(:username, :password)
  end
end
