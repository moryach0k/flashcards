class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  def new
    @user = User.new
  end

  def create 
    if @user = login(params[:email], params[:password])
      redirect_to(:root, notice: t("notice.logged_in"))
    else
      flash.now[:alert] = t("alert.login_failed")
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to(:root, notice: t("notice.logged_out"))
  end
end
