class Dashboard::UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to(:root, notice: t("notice.logged_out"))
  end
end
