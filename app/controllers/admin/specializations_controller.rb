class Admin::SpecializationsController < Admin::ApplicationController

  before_action :find_specialization, only: [:show, :edit, :update, :destroy]

  def index
    @report = SpecializationReport.new params[:specialization_report]
    @assets = @report.assets
  end

  def new
    @specialization = Specialization.new
  end

  def create
    @specialization = Specialization.new specialization_params
    if @specialization.save
      redirect_to admin_specializations_path, notice: "The specialization has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @specialization.update specialization_params
      redirect_to admin_specializations_path, notice: "The specialization has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @specialization.destroy
      redirect_to admin_specializations_path, notice: "The specialization has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_specializations_path, alert: e.message
    end
  end

  

private

  def find_specialization
    @specialization = Specialization.find params[:id]
  end

  def specialization_params
    if params[:action] == "update" and params[:specialization] and params[:specialization][:password].blank?
      params.require(:specialization).permit( :name, :email, :phone_number)
    else
      params.require(:specialization).permit!
    end
  end

end