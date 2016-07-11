class Admin::UserExperiencesController < Admin::ApplicationController

	before_action :find_user_experience, only: [:show, :edit, :update, :destroy]

  def index
    @report = UserExperienceReport.new params[:user_experience_report]
    @assets = @report.assets
  end

  def new
    @user_experience = UserExperience.new
  end

  def create
    @user_experience = UserExperience.new user_experience_params
    if @user_experience.save
      redirect_to admin_user_experiences_path, notice: "The user_experience has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @user_experience.update user_experience_params
      redirect_to admin_user_experiences_path, notice: "The user_experience has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @user_experience.destroy
      redirect_to admin_user_experiences_path, notice: "The user_experience has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_user_experiences_path, alert: e.message
    end
  end

  

private

  def find_user_experience
    @user_experience = Userexperience.find params[:id]
  end

  def user_experience_params
    if params[:action] == "update" and params[:user_experience] and params[:user_experience][:password].blank?
      params.require(:user_experience).permit( :name, :email, :phone_number)
    else
      params.require(:user_experience).permit!
    end
  end
  
end
