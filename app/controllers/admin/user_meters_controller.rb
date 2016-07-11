class Admin::UserMetersController < Admin::ApplicationController

  before_action :find_user_meter, only: [:show, :edit, :update, :destroy]

  def index
    @report = UserMeterReport.new params[:user_meter_report]
    @assets = @report.assets
  end

  def new
    @user_meter = UserMeter.new
  end

  def create
    @user_meter = UserMeter.new user_meter_params
    if @user_meter.save
      redirect_to admin_user_meters_path, notice: "The user_meter has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @user_meter.update user_meter_params
      redirect_to admin_user_meters_path, notice: "The user_meter has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @user_meter.destroy
      redirect_to admin_user_meters_path, notice: "The user_meter has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_user_meters_path, alert: e.message
    end
  end

  

private

  def find_user_meter
    @user_meter = user_meter.find params[:id]
  end

  def user_meter_params
    if params[:action] == "update" and params[:user_meter] and params[:user_meter][:password].blank?
      params.require(:user_meter).permit( :name, :email, :phone_number)
    else
      params.require(:user_meter).permit!
    end
  end

end