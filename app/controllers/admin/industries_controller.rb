class Admin::IndustriesController < Admin::ApplicationController

  before_action :find_industry, only: [:show, :edit, :update, :destroy]

  def index
    @report = IndustryReport.new params[:industry_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @industry = Industry.new
  end

  def create
    @industry = Industry.new industry_params
    if @industry.save
      redirect_to admin_industries_path, notice: "The industry has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @industry.update industry_params
      redirect_to admin_industries_path, notice: "The industry has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @industry.destroy
      redirect_to admin_industries_path, notice: "The industry has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_industries_path, alert: e.message
    end
  end

  

private

  def find_industry
    @industry = Industry.find params[:id]
  end

  def industry_params
    params.require(:industry).permit!
  end

end