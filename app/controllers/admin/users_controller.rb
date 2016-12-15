class Admin::UsersController < Admin::ApplicationController
respond_to :json, :html
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @report = UserReport.new params[:user_report]
    @assets = @report.assets.page( params[:page])
    respond_to do |format|
      format.html
      format.csv { send_data @report.to_csv }
    end
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.welcome(@user,params[:user][:password]).deliver_now
      redirect_to admin_users_path, notice: "The user has been created successfully."
    else
      render action: :new
    end
  end

  def show
    @user = User.find params[:id]
    @educations = @user.user_educations
  end

  def edit    
  end

  def update    
    if @user.update user_params
      redirect_to admin_users_path, notice: "The user has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @user.destroy
      redirect_to admin_users_path, notice: "The user has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_users_path, alert: e.message
    end
  end

  def flop
    @user = User.find(params[:user_id])
    @user.file_status = !@user.file_status # flop the file status
    @user.save
    redirect_to admin_user_path(@user.id)
  end

  def flop_marketiq
    @user_marketiq = UserMarketiq.find(params[:user_id])
    @user_marketiq.status = !@user_marketiq.status # flop the status
    @user_marketiq.save
    redirect_to admin_user_path(@user_marketiq.user_id)
  end

  def flop_award
    @user_award = UserAward.find(params[:user_id])
    @user_award.file_status = !@user_award.file_status # flop the file status
    @user_award.save
    redirect_to admin_user_path(@user_award.user_id)
  end

  def flop_certificate
    @user_certificate = UserCertificate.find(params[:user_id])
    @user_certificate.file_status = !@user_certificate.file_status # flop the file status
    @user_certificate.save
    redirect_to admin_user_path(@user_certificate.user_id)
  end

  def flop_futuregoal
    @user_futuregoal = UserFutureGoal.find(params[:user_id])
    @user_futuregoal.file_status = !@user_futuregoal.file_status # flop the file status
    @user_futuregoal.save
    redirect_to admin_user_path(@user_futuregoal.user_id)
  end

  def flop_workingenv
    @user_workingenv = UserEnvironment.find(params[:user_id])
    @user_workingenv.file_status = !@user_workingenv.file_status # flop the file status
    @user_workingenv.save
    redirect_to admin_user_path(@user_workingenv.user_id)
  end

  def flop_job_education
    @user_job_education = UserEducation.find(params[:user_id])
    @user_job_education.file_status = !@user_job_education.file_status # flop the file status
    @user_job_education.save
    redirect_to admin_user_path(@user_job_education.user_id)
  end

  def flop_experience
    @user_experience = UserExperience.find(params[:user_id])
    @user_experience.file_status = !@user_experience.file_status # flop the file status
    @user_experience.save
    redirect_to admin_user_path(@user_experience.user_id)
  end

  def flop_prework
    @user_prework = UserPreferredWork.find(params[:user_id])
    @user_prework.file_status = !@user_prework.file_status # flop the file status
    @user_prework.save
    redirect_to admin_user_path(@user_prework.user_id)
  end

  def flop_whizquiz
    @user_whizquiz = UserWhizquiz.find(params[:user_id])
    @user_whizquiz.file_status = !@user_whizquiz.file_status # flop the file status
    @user_whizquiz.save
    redirect_to admin_user_path(@user_whizquiz.user_id)
  end

  def flop_curricular
    @user_curricular = UserCurricular.find(params[:user_id])
    @user_curricular.file_status = !@user_curricular.file_status # flop the file status
    @user_curricular.save
    redirect_to admin_user_path(@user_curricular.user_id)
  end

  def flop_reference
    @user_reference = UserReference.find(params[:user_id])
    @user_reference.file_status = !@user_reference.file_status # flop the file status
    @user_reference.save
    redirect_to admin_user_path(@user_reference.user_id)
  end

  def flop_student_education
    @user_student_education = StudentEducation.find(params[:user_id])
    @user_student_education.file_status = !@user_student_education.file_status # flop the file status
    @user_student_education.save
    redirect_to admin_user_path(@user_student_education.user_id)
  end

  def flop_marksheet
    @user_marksheet = UserMarksheet.find(params[:user_id])
    @user_marksheet.file_status = !@user_marksheet.file_status # flop the file status
    @user_marksheet.save
    redirect_to admin_user_path(@user_marksheet.user_id)
  end

  def flop_project
    @user_project = UserProject.find(params[:user_id])
    @user_project.file_status = !@user_project.file_status # flop the file status
    @user_project.save
    redirect_to admin_user_path(@user_project.user_id)
  end

  def flop_affiliation
    @user_affiliation = FacultyAffiliation.find(params[:user_id])
    @user_affiliation.file_status = !@user_affiliation.file_status # flop the file status
    @user_affiliation.save
    redirect_to admin_user_path(@user_affiliation.user_id)
  end

  def flop_workshop
    @user_workshop = FacultyWorkshop.find(params[:user_id])
    @user_workshop.file_status = !@user_workshop.file_status # flop the file status
    @user_workshop.save
    redirect_to admin_user_path(@user_workshop.user_id)
  end

  def flop_publication
    @user_publication = FacultyPublication.find(params[:user_id])
    @user_publication.file_status = !@user_publication.file_status # flop the file status
    @user_publication.save
    redirect_to admin_user_path(@user_publication.user_id)
  end

  def flop_research
    @user_research = FacultyResearch.find(params[:user_id])
    @user_research.file_status = !@user_research.file_status # flop the file status
    @user_research.save
    redirect_to admin_user_path(@user_research.user_id)
  end

  

private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    if params[:action] == "update" and params[:user] and params[:user][:password].blank?
      params.require(:user).permit( :name, :email, :phone_number)
    else
      params.require(:user).permit!
    end
  end

  def filter_params
    params.fetch(:user, {}).
    permit(
      :roles => []
      )
  end

end