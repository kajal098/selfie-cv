namespace :cronjob do

	desc "This task is called by the Heroku scheduler add-on"
	task :marketiq => :environment do
	  puts "Updating feed..."
	  @user = User.find 1
	  puts @user
	end


end
