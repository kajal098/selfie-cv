class Admin::CompanyStocksController < Admin::ApplicationController

  before_action :find_company_stock, only: [:show, :edit, :update, :destroy]

  def index
    @report = CompanyStockReport.new params[:company_stock_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @company_stock = CompanyStock.new
  end

  def create
    @company_stock = CompanyStock.new company_stock_params
    if @company_stock.save
      redirect_to admin_company_stocks_path, notice: "The company stock created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @company_stock.update company_stock_params
      redirect_to admin_company_stocks_path, notice: "The company stock updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @company_stock.destroy
      redirect_to admin_company_stocks_path, notice: "The company stock deleted successfully."
    rescue Exception => e      
      redirect_to admin_company_stocks_path, alert: e.message
    end
  end

  

private

  def find_company_stock
    @company_stock = CompanyStock.find params[:id]
  end

  def company_stock_params
    if params[:action] == "update" and params[:company_stock]
      params.require(:company_stock).permit( :name, :email, :phone_number)
    else
      params.require(:company_stock).permit!
    end
  end

end