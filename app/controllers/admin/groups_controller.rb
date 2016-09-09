class Admin::GroupsController < Admin::ApplicationController

  before_action :find_group, only: [:show, :edit, :update, :destroy]

  def index
    @report = GroupReport.new params[:group_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @group = Group.new
  end

  def create
    
  end

  def show

  end

  def edit    
  end

  def update    
    
  end

  def destroy
    
  end

  

private

  def find_group
    @group = Group.find params[:id]
  end

  def group_params
      params.require(:group).permit!
  end

end