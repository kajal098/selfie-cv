class Admin::VideoUploadsController < Admin::ApplicationController
respond_to :json, :html
  before_action :find_video_upload, only: [:show, :edit, :update, :destroy]

  def index
    @report = VideoUploadReport.new params[:video_upload_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @video_upload = VideoUpload.new
  end

  def create
    @video_upload = VideoUpload.new video_upload_params
    if @video_upload.save
      redirect_to admin_video_uploads_path, notice: "The video has been uploaded successfully."
    else
      render action: :new
    end
  end

  def show
    @video_upload = VideoUpload.find params[:id]
  end

  def edit    
  end

  def update    
    if @video_upload.update video_upload_params
      redirect_to admin_video_uploads_path, notice: "The video has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @video_upload.destroy
      redirect_to admin_video_uploads_path, notice: "The video has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_video_uploads_path, alert: e.message
    end
  end

private

  def find_video_upload
    @video_upload = VideoUpload.find params[:id]
  end

  def video_upload_params
    params[:file] ? params.require(:video_upload).permit! : params.require(:video_upload).permit!
  end

end