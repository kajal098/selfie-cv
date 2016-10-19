namespace :cronjob do

	desc "This task is called by the Heroku scheduler add-on"
	task :update_feed => :environment do
	  puts "Updating feed..."
	  @user = User.find 1
	  return @user
	end

end
