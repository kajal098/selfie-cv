class Admin::MessagesController < Admin::ApplicationController

  before_action :find_message, only: [:show, :edit, :update, :destroy]

  def index
    @report = MessageReport.new params[:message_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new message_params
    if @message.save
      redirect_to admin_messages_path, notice: "The message has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @message.update message_params
      redirect_to admin_messages_path, notice: "The message has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @message.destroy
      redirect_to admin_messages_path, notice: "The message has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_messages_path, alert: e.message
    end
  end

  

private

  def find_message
    @message = Message.find params[:id]
  end

  def message_params
    params.require(:message).permit!
  end

end