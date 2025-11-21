class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    users_backoffice_welcome_index_path
  end
=begin
  protected
    def layout_by_resource
      if devise_controller? && resource_name == :admin
        "admins_devise"
      elsif devise_controller? && resource_name == :user
        "users_devise"
      else
        "application"
      end
    end

  protected
    def layout_by_resource
      if devise_controller?
        "#{resource_class.to_s.downcase}_devise"
      else
        "application"
      end
    end
=end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name ])
  end

  def layout_by_resource
    devise_controller? ? "#{resource_name}_devise" : "application"
  end
end
