# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Rpush::Gcm::App.any?
  app = Rpush::Gcm::App.new
  app.name = "android_app"
  app.auth_key = "AIzaSyDvovMZRqsuEeN8KwuZ0qwLIwh1A16MxSs"
  app.connections = 1
  app.save!
end

unless Rpush::Apns::App.any?
  app = Rpush::Apns::App.new
  app.name = "ios"
  app.certificate = File.read Rails.root.join('docs','sandbox.pem')
  app.environment = "sandbox" # APNs environment.
  app.password = ENV['APNS_PASSWORD']
  app.connections = 1
  app.save!
end

UserPercentage.create(ptype: 'Jobseeker', key: 'resume', value: 40)
UserPercentage.create(parent_id: 1, ptype: 'Jobseeker', key: 'resume_info', value: 50)
UserPercentage.create(parent_id: 1, ptype: 'Jobseeker', key: 'education', value: 25)
UserPercentage.create(parent_id: 1, ptype: 'Jobseeker', key: 'experience', value: 25)
UserPercentage.create(ptype: 'Jobseeker', key: 'achievement', value: 10)
UserPercentage.create(parent_id: 5, ptype: 'Jobseeker', key: 'award', value: 50)
UserPercentage.create(parent_id: 5, ptype: 'Jobseeker', key: 'certificate', value: 50)
UserPercentage.create(ptype: 'Jobseeker', key: 'extra', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'whizquiz', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'futuregoal', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'workingenv', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'references', value: 10)



UserPercentage.create(ptype: 'Company', key: 'info', value: 50)
UserPercentage.create(ptype: 'Company', key: 'corporate', value: 10)
UserPercentage.create(ptype: 'Company', key: 'growth', value: 10)
UserPercentage.create(parent_id: 15, ptype: 'Company', key: 'evalution', value: 50)
UserPercentage.create(parent_id: 15, ptype: 'Company', key: 'futuregoal', value: 50)
UserPercentage.create(ptype: 'Company', key: 'achievement', value: 10)
UserPercentage.create(parent_id: 18, ptype: 'Company', key: 'award', value: 50)
UserPercentage.create(parent_id: 18, ptype: 'Company', key: 'certificate', value: 50)
UserPercentage.create(ptype: 'Company', key: 'gallery', value: 10)
UserPercentage.create(ptype: 'Company', key: 'workingenv', value: 10)



UserPercentage.create(ptype: 'Student', key: 'info', value: 20)
UserPercentage.create(ptype: 'Student', key: 'education', value: 40)
UserPercentage.create(parent_id: 24, ptype: 'Student', key: 'education', value: 50)
UserPercentage.create(parent_id: 24, ptype: 'Student', key: 'marksheet', value: 40)
UserPercentage.create(parent_id: 24, ptype: 'Student', key: 'project', value: 10)
UserPercentage.create(ptype: 'Student', key: 'achievement', value: 20)
UserPercentage.create(parent_id: 28, ptype: 'Student', key: 'award', value: 50)
UserPercentage.create(parent_id: 28, ptype: 'Student', key: 'certificate', value: 50)
UserPercentage.create(ptype: 'Student', key: 'extra', value: 10)
UserPercentage.create(ptype: 'Student', key: 'futuregoal', value: 10)



UserPercentage.create(ptype: 'Faculty', key: 'info', value: 20)
UserPercentage.create(ptype: 'Faculty', key: 'experience', value: 60)
UserPercentage.create(parent_id: 34, ptype: 'Faculty', key: 'affiliation', value: 30)
UserPercentage.create(parent_id: 34, ptype: 'Faculty', key: 'workshop', value: 30)
UserPercentage.create(parent_id: 34, ptype: 'Faculty', key: 'publication', value: 20)
UserPercentage.create(parent_id: 34, ptype: 'Faculty', key: 'research', value: 20)
UserPercentage.create(ptype: 'Faculty', key: 'achievement', value: 20)
UserPercentage.create(parent_id: 39, ptype: 'Faculty', key: 'award', value: 50)
UserPercentage.create(parent_id: 39, ptype: 'Faculty', key: 'certificate', value: 50)

UserPercentage.create(ptype: 'site', key: 'like', value: 8)
UserPercentage.create(ptype: 'site', key: 'star', value: 8)
UserPercentage.create(ptype: 'site', key: 'updatecv', value: 8)
UserPercentage.create(ptype: 'site', key: 'share', value: 8)
UserPercentage.create(ptype: 'site', key: 'viewed', value: 8)
UserPercentage.create(ptype: 'site', key: 'marketIQ', value: 15)
UserPercentage.create(ptype: 'site', key: 'stockexchange', value: 35)
UserPercentage.create(ptype: 'site', key: 'profilemeter', value: 10)

user = User.create(email: 'admin@example.com', password: '12345678' , username: 'admin' , role: 'Admin', total_per:10 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create(email: 'michel@example.com', password: '12345678' , username: 'michel' , role: 'Admin', total_per:20 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

user = User.create!(email: 'trupti@gmail.com', password:'12345678' , username: 'trupti' , role: 'Student', first_name: 'trupti' , total_per:30) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'anni@gmail.com', password:'12345678' , username: 'anni' , role: 'Student', first_name: 'anni' , total_per:40) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'julia@gmail.com', password:'12345678' , username: 'julia' , role: 'Student', first_name: 'julia' , total_per:50) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'mary@gmail.com', password:'12345678' , username: 'mary' , role: 'Student', first_name: 'mary' , total_per:60) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'nicolecross1579@gmail.com', password:'12345678' , username: 'nicole' , role: 'Student', first_name: 'nicole' , total_per:70) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'kianstokes@gmail.com', password:'12345678' , username: 'kianstokes' , role: 'Student', first_name: 'kianstokes' , total_per:80) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

user = User.create!(email: 'daisy@gmail.com', password: '12345678' , username: 'daisy' , role: 'Faculty', total_per:90 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'jekky@gmail.com', password: '12345678' , username: 'jekky' , role: 'Faculty', total_per:10 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'angela@gmail.com', password: '12345678' , username: 'angela' , role: 'Faculty', total_per:20 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'diana@gmail.com', password: '12345678' , username: 'diana' , role: 'Faculty', total_per:30 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

user = User.create!(email: 'gunja@gmail.com', password:'12345678' , username: 'gunja' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655 , total_per:40) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'sam@gmail.com', password: '12345678' , username: 'sam' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655, total_per:50 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'riya@gmail.com', password: '12345678' , username: 'riya' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655, total_per:60 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'self@gmail.com', password: '12345678' , username: 'self' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655, total_per:70 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'thomas@gmail.com', password: '12345678' , username: 'thomas' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655, total_per:80 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'victor@gmail.com', password: '12345678' , username: 'victor' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655, total_per:90 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)


user = User.create!(email: 'parnel@gmail.com', password: '12345678' , username: 'parnel' , role: 'Company', total_per:10 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'kriya@gmail.com', password: '12345678' , username: 'kriya' , role: 'Company', total_per:20 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'niya@gmail.com', password: '12345678' , username: 'niya' , role: 'Company', total_per:30 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'abc@gmail.com', password: '12345678' , username: 'abc' , role: 'Company', total_per:40 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)


Course.create(name: "be")
Course.create(name: "me")
Course.create(name: "mba")
Course.create(name: "phd")
Course.create(name: "btech")
Course.create(name: "mca")
Course.create(name: "bca")
Course.create(name: "commerce")
Course.create(name: "science")
Course.create(name: "arts")
Course.create(name: "cooking")

Company.create(name: "E Commerce")
Company.create(name: "Social Media")
Company.create(name: "Marketplace")
Company.create(name: "Product Development")
Company.create(name: "Public")
Company.create(name: "Software Development")
Company.create(name: "Corporation")
Company.create(name: "Web Development")
Company.create(name: "Healthcare Technology")
Company.create(name: "Business Consulting")
Company.create(name: "Marketing Services")

Industry.create(name: "Agriculture & Forestry")
Industry.create(name: "Business & Information")
Industry.create(name: "Education")
Industry.create(name: "Finance & Insurance")
Industry.create(name: "Food & Hospitality")
Industry.create(name: "Gaming")
Industry.create(name: "Health Services")
Industry.create(name: "Motor Vehicle")
Industry.create(name: "Natural Resources")
Industry.create(name: "Personal Services")
Industry.create(name: "Real Estate & Housing")

Specialization.create(name: "computer")
Specialization.create(name: "electrical")
Specialization.create(name: "information technology")
Specialization.create(name: "civil")
Specialization.create(name: "power and electronics")
Specialization.create(name: "chemical")
Specialization.create(name: "mechanical")
Specialization.create(name: "software engineering")
Specialization.create(name: "systems engineering")
Specialization.create(name: "textiles")
Specialization.create(name: "mining")


Setting.create(resume_per: 40, achievement_per: 10, curricular_per: 10, whizquiz_per: 10, future_goal_per: 10, working_env_per: 10,reference_per: 10,site_name: 'Selfie Cv', site_email: 'selfiecv@gmailcom',site_phone: 12345678,site_fax: 1234567,facebook_url:'http://www.facebook.com/selfiecv',twitter_url:'http://www.twitter.com/selfiecv',google_plus_url: 'http://www.googleplus.com/selfiecv')

QuickMessage.create(text: 'Your homework for today is.', role: 'faculty')
QuickMessage.create(text: 'Great work class !! Keep it up !!', role: 'faculty')
QuickMessage.create(text: 'Tommorrow we will be starting a new chapter. Make sure you dont miss it.', role: 'faculty')
QuickMessage.create(text: 'Many students are having problems with current chapter. I know its difficult but dont worry i am always here to help you.', role: 'faculty')
QuickMessage.create(text: 'You have a surprise test tomorrow.', role: 'faculty')
QuickMessage.create(text: 'Life teaching : The best preparation for tomorrow is doing your best today.', role: 'faculty')
QuickMessage.create(text: 'If you are facing any perticular problem, do feel free to share with me.', role: 'faculty')

QuickMessage.create(text: 'My query for current chapter.', role: 'student')
QuickMessage.create(text: 'Thank you for help mam/sir.', role: 'student')
QuickMessage.create(text: 'I will not able to come class tomorrow due to fever.', role: 'student')



Whizquiz.create(question: 'Grand Central Terminal, Park Avenue, New York is the worlds', answer: 'largest railway station', status: true)
Whizquiz.create(question: 'Entomology is the science that studies', answer: 'Insects', status: true)
Whizquiz.create(question: 'Eritrea, which became the 182nd member of the UN in 1993, is in the continent of', answer: 'Africa')
Whizquiz.create(question: 'Brass gets discoloured in air because of the presence of which of the following gases in air?', answer: 'Hydrogen sulphide')
Whizquiz.create(question: 'Which of the following is a non metal that remains liquid at room temperature?', answer: 'Bromine', status: true)
Whizquiz.create(question: 'Chlorophyll is a naturally occurring chelate compound in which central metal is', answer: 'magnesium', status: true)
Whizquiz.create(question: 'The name of the Laccadive, Minicoy and Amindivi islands was changed to Lakshadweep by an Act of Parliament in', answer: '1973', status: true)
Whizquiz.create(question: 'The members of the Rajya Sabha are elected by', answer: 'elected members of the legislative assembly', status: true)
Whizquiz.create(question: 'The power to decide an election petition is vested in the', answer: 'High courts')
Whizquiz.create(question: 'The present Lok Sabha is the', answer: '16th Lok Sabha')
Whizquiz.create(question: 'The Homolographic projection has the correct representation of', answer: 'area', status: true)
Whizquiz.create(question: 'The intersecting lines drawn on maps and globes are', answer: 'geographic grids')
Whizquiz.create(question: 'The nucleus of an atom consists of', answer: 'protons and neutrons')
Whizquiz.create(question: 'The most electronegative element among the following is', answer: 'fluorine')
Whizquiz.create(question: 'The metal used to recover copper from a solution of copper sulphate is', answer: 'Fe')
Whizquiz.create(question: 'The metallurgical process in which a metal is obtained in a fused state is called', answer: 'smelting')
Whizquiz.create(question: '	
The position of the president which was undermined by the 42nd amendment was sub-sequently somewhat retrieved by the', answer: '44th amendment')








