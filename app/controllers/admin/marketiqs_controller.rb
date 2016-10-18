class Admin::MarketiqsController < Admin::ApplicationController

  before_action :find_marketiq, only: [:show, :edit, :update, :destroy]

  def index
    @report = MarketiqReport.new params[:marketiq_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @marketiq = Marketiq.new
  end

  def create
    @marketiq = Marketiq.new marketiq_params
    if @marketiq.save
      redirect_to admin_marketiqs_path, notice: "The marketiq has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @marketiq.update marketiq_params
      redirect_to admin_marketiqs_path, notice: "The marketiq has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @marketiq.destroy
      redirect_to admin_marketiqs_path, notice: "The marketiq has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_marketiqs_path, alert: e.message
    end
  end

  # def flop
  #   @marketiq = Marketiq.find(params[:marketiq_id])
  #   @marketiq.status = !@marketiq.status # flop the status
  #   @marketiq.save
  #   redirect_to admin_marketiqs_path
  # end

  

private

  def find_marketiq
    @marketiq = Marketiq.find params[:id]
  end

  def marketiq_params
    params.require(:marketiq).permit!
  end

end