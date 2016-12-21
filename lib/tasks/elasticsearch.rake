require 'elasticsearch/rails/tasks/import'
namespace :elasticsearch do 

  desc 'Reset mapping and import data'
  task :import => :environment do

    # reset user
    User.__elasticsearch__.create_index! force: true
    User.__elasticsearch__.refresh_index!
    User.import

  end

end