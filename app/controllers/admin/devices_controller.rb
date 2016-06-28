class Admin::DevicesController < Admin::ApplicationController

  before_action :find_device, only: [:edit, :update, :destroy]

  def index
    @devices = Device.all
  end

  def new
    @device = Device.new
  end

  def create
    @device = Device.new device_params
    if @device.save
      redirect_to admin_devices_path, notice: "Device saved successfully."
    else
      render action: :new
    end
  end

  def edit
      
  end

  def update    
    if @device.update device_params
      redirect_to admin_devices_path, notice: "Device saved successfully."
    else
      render action: :new
    end
  end

  def destroy
    begin
      @device.destroy
      redirect_to admin_devices_path, notice: "Device deleted successfully."
    rescue Exception => e
      redirect_to admin_devices_path, alert: e.message
    end
  end

private 

  def device_params
    params.require(:device).permit(:name)
  end

  def find_device
    @device = Device.find params[:id]  
  end

end