class Admin::ChatsController < Admin::ApplicationController

  before_action :find_chat, only: [:show, :edit, :update, :destroy]

  def index
    @report = ChatReport.new params[:chat_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new chat_params
    if @chat.save
      redirect_to admin_chats_path, notice: "The chat has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @chat.update chat_params
      redirect_to admin_chats_path, notice: "The chat has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @chat.destroy
      redirect_to admin_chats_path, notice: "The chat has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_chats_path, alert: e.message
    end
  end

  

private

  def find_chat
    @chat = Chat.find params[:id]
  end

  def chat_params
    if params[:action] == "update" and params[:chat] and params[:chat][:file].blank?
      params.require(:chat).permit( :file_type, :receiver_id, :sender_id, :quick_msg)
    else
      params.require(:chat).permit!
    end
  end

end