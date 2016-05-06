class SubsController < ApplicationController
  def index
    @subs = Sub.all
    render :index
  end

  def new
    @user = current_user
    render :new
  end

  def create
    @sub = current_user.subs.new(submitted_params)

    if @sub.save!
      redirect_to sub_url(@sub)
    else
      render :new
    end
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    @sub.update(submitted_params)

    if @sub.save!
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find_by_id(params[:id])

    if @sub.moderator_id == current_user.id
      render :edit
    else
      redirect_to sub_url
    end

  end

  private
  def submitted_params
    params.require(:sub).permit(:title, :description)
  end
end
