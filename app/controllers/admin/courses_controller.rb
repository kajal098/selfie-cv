class Admin::CoursesController < Admin::ApplicationController

  before_action :find_course, only: [:show, :edit, :update, :destroy]

  def index
    @report = CourseReport.new params[:course_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      redirect_to admin_courses_path, notice: "The course has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @course.update course_params
      redirect_to admin_courses_path, notice: "The course has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @course.destroy
      redirect_to admin_courses_path, notice: "The course has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_courses_path, alert: e.message
    end
  end

  

private

  def find_course
    @course = Course.find params[:id]
  end

  def course_params
    if params[:action] == "update" and params[:course]
      params.require(:course).permit( :name, :email, :phone_number)
    else
      params.require(:course).permit!
    end
  end

end