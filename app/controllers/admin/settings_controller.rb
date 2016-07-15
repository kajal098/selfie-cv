class Admin::SettingsController < Admin::ApplicationController
  def show
    @setting = Setting.first
  end
  def create
    @setting = Setting.first
    if @setting.update params.require(:setting).permit!      
      redirect_to admin_settings_path, notice: "Settings updated successfully."
    else
      render action: :show
    end
  end
  def update
    self.create
  end
  private
  def setting_params
    params.require(:setting).permit(:resume_per, :achievement_per, :curricular_per, :whizquiz_per, :future_goal_per, :Working_env_per, :reference_per, :site_name, :site_email, :site_phone, :site_fax, :facebook_url, :twitter_url, :google_plus_url)
  end
end
