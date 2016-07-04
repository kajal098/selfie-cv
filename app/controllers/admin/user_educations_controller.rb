class Admin::UserEducationsController < Admin::ApplicationController

	before_action :find_user_education, only: [:show, :edit, :update, :destroy]

  def index
    @report = UserEducationReport.new params[:user_education_report]
    @assets = @report.assets
  end

  def new
    @user_education = UserEducation.new
  end

  def create
    @user_education = UserEducation.new user_education_params
    if @user_education.save
      redirect_to admin_user_educations_path, notice: "The user_education has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @user_education.update user_education_params
      redirect_to admin_user_educations_path, notice: "The user_education has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @user_education.destroy
      redirect_to admin_user_educations_path, notice: "The user_education has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_user_educations_path, alert: e.message
    end
  end

  

private

  def find_user_education
    @user_education = UserEducation.find params[:id]
  end

  def user_education_params
    if params[:action] == "update" and params[:user_education] and params[:user_education][:password].blank?
      params.require(:user_education).permit( :name, :email, :phone_number)
    else
      params.require(:user_education).permit!
    end
  end
  
end
