class Admin::CategoriesController < Admin::ApplicationController

  before_action :find_category, only: [:show, :edit, :update, :destroy]

  def index
    @report = CategoryReport.new params[:category_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path, notice: "The category has been created successfully."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @category.update category_params
      redirect_to admin_categories_path, notice: "The category has been updated successfully."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @category.destroy
      redirect_to admin_categories_path, notice: "The category has been deleted successfully."
    rescue Exception => e      
      redirect_to admin_categories_path, alert: e.message
    end
  end

  

private

  def find_category
    @category = Category.find params[:id]
  end

  def category_params
    if params[:action] == "update" and params[:category]
      params.require(:category).permit( :name, :email, :phone_number)
    else
      params.require(:category).permit!
    end
  end

end