class BansController < ApplicationController
  def index
    @users = User.order(login: :asc)
    if current_user && current_user.login == 'ADM'
      Ban.all.each do |ban|
        if ban.expires_at < Time.now
          ban.destroy
        end
      end

      @bans = Ban.all
    else
      redirect_to root_url
    end
  end

  def new
    @user = User.find(params[:user_id])
  end

  def edit
    @ban = Ban.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    if Ban.find_by(user_id: @user.id)
      redirect_to bans_path
    end

    @ban = @user.build_ban(ban_params)
    if @ban.save
      redirect_to bans_path
    else
      render 'new'
    end
  end

  def update
    @ban = Ban.find(params[:id])

    if @ban.update(ban_params)
      redirect_to bans_path
    else
      render 'edit'
    end
  end

  def destroy
    @ban = Ban.find(params[:id])
    @ban.destroy

    redirect_to bans_path
  end

  private
    def ban_params
      params.require(:ban).permit(:reason, :expires_at)
    end
end