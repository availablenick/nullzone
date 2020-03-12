class AdmPanelController < ApplicationController
  def index
    if current_user && current_user.login == 'ADM'
      @users = User.order(login: :asc)
      @bans = Ban.all

      Ban.all.each do |ban|
        if !ban.permanent? && ban.expires_at < Time.now
          ban.destroy
        end
      end
    else
      redirect_to root_url
    end
  end
end
