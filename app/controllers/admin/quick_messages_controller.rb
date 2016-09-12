class Admin::QuickMessagesController < Admin::ApplicationController

  before_action :find_quick_message, only: [:show, :edit, :update, :destroy]

  def index
    @report = QuickMessageReport.new params[:quick_message_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @quick_message = QuickMessage.new
  end

  def create
    @quick_message = QuickMessage.new quick_message_params
    if @quick_message.save
      redirect_to admin_quick_messages_path, notice: "The quick message has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @quick_message.update quick_message_params
      redirect_to admin_quick_messages_path, notice: "The quick message has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @quick_message.destroy
      redirect_to admin_quick_messages_path, notice: "The quick message has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_quick_messages_path, alert: e.message
    end
  end

  

private

  def find_quick_message
    @quick_message = QuickMessage.find params[:id]
  end

  def quick_message_params
    params.require(:quick_message).permit!
  end

end