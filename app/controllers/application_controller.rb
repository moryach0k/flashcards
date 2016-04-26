class ApplicationController < ActionController::Base
  before_filter :set_locale
  before_action :require_login
  protect_from_forgery with: :exception

  def set_locale
    I18n.locale = :en
  end

  private
  
  def not_authenticated
    redirect_to login_path, alert: t("alert.login_first")
  end
end
