namespace :search do 

  desc 'Reset mapping and import data'
  task :reset => :environment do

    # reset user
    User.__elasticsearch__.create_index! force: true
    User.__elasticsearch__.refresh_index!
    User.import

  end

end