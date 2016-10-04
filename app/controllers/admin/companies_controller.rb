class Admin::CompaniesController < Admin::ApplicationController

  before_action :find_company, only: [:show, :edit, :update, :destroy]

  def index
    @report = CompanyReport.new params[:company_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new company_params
    if @company.save
      redirect_to admin_companies_path, notice: "The company has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @company.update company_params
      redirect_to admin_companies_path, notice: "The company has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @company.destroy
      redirect_to admin_companies_path, notice: "The company has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_companies_path, alert: e.message
    end
  end

  

private

  def find_company
    @company = Company.find params[:id]
  end

  def company_params
    if params[:action] == "update" and params[:company]
      params.require(:company).permit( :name, :email, :phone_number)
    else
      params.require(:company).permit!
    end
  end

end