class BansController < ApplicationController
  def index
    @bans = Ban.all
    Ban.all.each do |ban|
      if !ban.permanent? && ban.expires_at < Time.now
        ban.destroy
      end
    end
  end

  def new
    if current_user && current_user.login == 'ADM'
      @ban = Ban.new
      @user = User.find(params[:user_id])
    else
      redirect_to root_url
    end
  end

  def edit
    if current_user && current_user.login == 'ADM'
      @ban = Ban.find(params[:id])
    else
      redirect_to root_url
    end
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
      params.require(:ban).permit(:reason, :permanent, :expires_at)
    end
end
