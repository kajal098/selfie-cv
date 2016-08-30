class Admin::DashboardController < Admin::ApplicationController

  def index
	
	@users = User.all
	@student = User.where(role: 1).order("created_at desc").limit(3)
	@faculty = User.where(role: 2).order("created_at desc").limit(3)
	@jobseeker = User.where(role: 3).order("created_at desc").limit(3)
	@company = User.where(role: 4).order("created_at desc").limit(3)
  
	end

  def feed
    scope = PublicActivity::Activity.order(id: :desc)    
    @activities = scope.limit(100).offset(params[:offset].to_i)
  end

end