class Admin::UserPercentagesController < Admin::ApplicationController
  
  def show
    @user_percentage = UserPercentage.new
  end

  def create
  	@main_percentage = 0
  	@status = true
  	# render json: params[:user_percentage]
  	# return
  	params[:user_percentage].each do |value|
  		if value[1].is_a?(String)
  			@main_percentage = @main_percentage + value[1].to_i
  		else
  			@sub_percentage = 0
  			value[1].each do |sub|
  				@sub_percentage = @sub_percentage + sub[1].to_i
  			end
  			if @sub_percentage != 100
  				@status = false 
  				break
  			end
  			puts "#{@status}" 
  		end
  	end
  	@status = false if @main_percentage != 100
  	if @status
	    params[:user_percentage].each do |value|
	    	if value[1].is_a?(String)
	    		@u = UserPercentage.fetch(params[:ptype]).where(key: value[0]).first
	    		@u.update_column("value", value[1])
	    	else
	    		value[1].each do |sub|
	    			@u = UserPercentage.fetch(params[:ptype]).where(key: sub[0]).first
	    			@u.update_column("value", sub[1])
	    		end
	    	end
	    end
      	redirect_to admin_user_percentages_path, notice: "Percentage updated successfully."
	else	
    	redirect_to admin_user_percentages_path, alert: "Please enter valid percentage value."
  	end
  end

end
