class Admin::ApplicationController < ActionController::Base

  before_action :authenticate_user!, :backend_roles

  protect_from_forgery with: :exception

  layout 'admin'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
  end

  def backend_roles    
    unless current_user.role == "admin"
      #redirect_to '/403', :notice => "You are not allowed to access this section" and return
    end
  end

end