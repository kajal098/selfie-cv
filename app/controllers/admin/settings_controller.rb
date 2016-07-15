class Admin::SettingsController < Admin::ApplicationController

def show
    @setting = Setting.new
  end

  def create
    @setting = Setting.new  
    if @setting.update params.require(:setting).permit!      
      redirect_to admin_settings_path, notice: "Settings updated successfully."
    else
      render action: :show
    end
  end

  def update
    self.create
  end

  
end

