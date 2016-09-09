class Admin::GroupUsersController < Admin::ApplicationController

  before_action :find_group_user, only: [:show, :edit, :update, :destroy]

  def index
    @report = GroupUserReport.new params[:group_user_report]
    @assets = @report.assets.page( params[:page])
  end

  def new
    @group_user = GroupUser.new
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

  def find_group_user
    @group_user = GroupUser.find params[:id]
  end

  def group_user_params
      params.require(:group_user).permit!
  end

end