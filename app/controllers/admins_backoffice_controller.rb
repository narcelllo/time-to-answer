class AdminsBackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout "admins_backoffice"

  def force_admin_login
    if user_signed_in?
      sign_out current_user
    end

  redirect_to admins_backoffice_admins_path
  end
end
