class Admin::UserPercentagesController < Admin::ApplicationController
  
  def show
    @user_percentage = UserPercentage.new
  end

  def create
    params[:user_percentage].each do |value|
    	@u = UserPercentage.fetch(params[:ptype]).where(key: value[0]).first
    	@u.update_column("value", value[1])
    end
    redirect_to admin_user_percentages_path, notice: "Percentage updated successfully."
  end

end
