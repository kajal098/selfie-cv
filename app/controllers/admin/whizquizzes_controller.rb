class Admin::WhizquizzesController < Admin::ApplicationController

  before_action :find_whizquiz, only: [:show, :edit, :update, :destroy]

  def index
    @report = WhizquizReport.new params[:whizquiz_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @whizquiz = Whizquiz.new
  end

  def create
    @whizquiz = Whizquiz.new whizquiz_params
    if @whizquiz.save
      redirect_to admin_whizquizzes_path, notice: "The whizquiz has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @whizquiz.update whizquiz_params
      redirect_to admin_whizquizzes_path, notice: "The whizquiz has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @whizquiz.destroy
      redirect_to admin_whizquizzes_path, notice: "The whizquiz has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_whizquizzes_path, alert: e.message
    end
  end

  

private

  def find_whizquiz
    @whizquiz = Whizquiz.find params[:id]
  end

  def whizquiz_params
    if params[:action] == "update" and params[:whizquiz]
      params.require(:whizquiz).permit( :question, :answer, :active)
    else
      params.require(:whizquiz).permit!
    end
  end

end