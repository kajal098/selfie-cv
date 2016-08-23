class Admin::StandardsController < Admin::ApplicationController

  before_action :find_standard, only: [:show, :edit, :update, :destroy]

  def index
    @report = StandardReport.new params[:standard_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @standard = Standard.new
  end

  def create
    @standard = Standard.new standard_params
    if @standard.save
      redirect_to admin_standards_path, notice: "The standard has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @standard.update standard_params
      redirect_to admin_standards_path, notice: "The standard has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @standard.destroy
      redirect_to admin_standards_path, notice: "The standard has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_standards_path, alert: e.message
    end
  end

  

private

  def find_standard
    @standard = Standard.find params[:id]
  end

  def standard_params
    if params[:action] == "update" and params[:standard] and params[:standard][:password].blank?
      params.require(:standard).permit( :name, :email, :phone_number)
    else
      params.require(:standard).permit!
    end
  end

end