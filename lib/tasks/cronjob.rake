namespace :cronjob do

	desc "This task is called by the Heroku scheduler add-on"
	task :find_user => :environment do
	  puts "For send marketiq question notification to users..."
	  @users = User.where(:role => [3,4])
	  @users.each do |user|
	  	puts user.username
	  end
	end


end
