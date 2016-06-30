class Admin::DashboardController < Admin::ApplicationController

  def index
	
	@user = User.order("created_at desc").limit(5)
  
	end

  def feed
    scope = PublicActivity::Activity.order(id: :desc)    
    @activities = scope.limit(100).offset(params[:offset].to_i)
  end

end