class Admin::StockCountriesController < Admin::ApplicationController

  before_action :find_stock_country, only: [:show, :edit, :update, :destroy]

  def index
    @report = StockCountryReport.new params[:stock_country_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @stock_country = StockCountry.new
  end

  def create
    @stock_country = StockCountry.new stock_country_params
    if @stock_country.save
      redirect_to admin_stock_countries_path, notice: "The country has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @stock_country.update stock_country_params
      redirect_to admin_stock_countries_path, notice: "The country has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @stock_country.destroy
      redirect_to admin_stock_countries_path, notice: "The country has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_stock_countries_path, alert: e.message
    end
  end

  

private

  def find_stock_country
    @stock_country = StockCountry.find params[:id]
  end

  def stock_country_params
    if params[:action] == "update" and params[:stock_country]
      params.require(:stock_country).permit( :name, :email, :phone_number)
    else
      params.require(:stock_country).permit!
    end
  end

end