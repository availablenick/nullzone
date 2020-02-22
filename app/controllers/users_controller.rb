class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.avatar.attach(user_params[:avatar])

    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    @user.avatar.purge if @user.avatar.attached?

    if user_params[:avatar]
      @user.avatar.attach(user_params[:avatar])
    end

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.avatar.purge if @user.avatar.attached?
    @user.destroy

    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:login, :password, :signature, :avatar)
    end
end
