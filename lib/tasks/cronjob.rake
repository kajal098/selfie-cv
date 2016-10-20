namespace :cronjob do

	desc "This task is called by the Heroku scheduler add-on"
	task :market_iq => :environment do
	  puts "For send marketiq question notification to users..."


	  @users = User.where(:role => [3,4])
	  @users.each do |user|
	  	puts user.username	

	  # if user.role == 'Jobseeker'
   #        @marketiq = Marketiq.where(role: 'false').where(specialization_id: user.user_educations.pluck('specialization_id')).order("RANDOM()").first
   #    elsif user.role == 'Company'        
   #        @marketiq = Marketiq.where(role: 'true').where(industry_id: user.industry_id).order("RANDOM()").first
   #    end


   #    if @marketiq
   #      @user_marketiq = UserMarketiq.new user_id: user.id, marketiq_id: @marketiq.id
   #      error!({error: @user_marketiq.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_marketiq.save
   #    end

  
	  	#Device.notify user.active_devices, { msg: "You have new Market IQ question.", type: 'marketiq_que' }
	  end
	  

	end


end
