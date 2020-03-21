class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if current_user
      redirect_to root_url
    else
      @user = User.new
    end
  end

  def edit
    @user = User.find(params[:id])
    if !current_user || (current_user.login != 'ADM' && @user != current_user)
      redirect_to root_url
    end
  end

  def create
    @user = User.new(user_params)
    @user.avatar.attach(user_params[:avatar])

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
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
    if current_user && (current_user.login == 'ADM' || @user == current_user)
      @user.avatar.purge if @user.avatar.attached?
      @user.destroy
      
      if @user == current_user
        session.delete(:user_id)
        @current_user = nil
      end

      redirect_to users_path
    else
      redirect_to root_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:login, :password, :password_confirmation, :signature, :avatar)
    end
end
