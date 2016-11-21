unless Rpush::Gcm::App.any?
  app = Rpush::Gcm::App.new
  app.name = "android_app"
  app.auth_key = "AIzaSyDvovMZRqsuEeN8KwuZ0qwLIwh1A16MxSs"
  app.connections = 1
  app.save!
end

# unless Rpush::Apns::App.any?
#   app = Rpush::Apns::App.new
#   app.name = "ios"
#   app.certificate = File.read Rails.root.join('docs','sandbox.pem')
#   app.environment = "sandbox" # APNs environment.
#   app.password = ENV['APNS_PASSWORD']
#   app.connections = 1
#   app.save!
# end

UserPercentage.create(ptype: 'Jobseeker', key: 'resume', value: 40)
UserPercentage.create(parent_id: 1, ptype: 'Jobseeker', key: 'resume_info', value: 50)
UserPercentage.create(parent_id: 1, ptype: 'Jobseeker', key: 'education', value: 25)
UserPercentage.create(parent_id: 1, ptype: 'Jobseeker', key: 'experience', value: 13)
UserPercentage.create(parent_id: 1, ptype: 'Jobseeker', key: 'prework', value: 12)
UserPercentage.create(ptype: 'Jobseeker', key: 'achievement', value: 10)
UserPercentage.create(parent_id: 6, ptype: 'Jobseeker', key: 'award', value: 50)
UserPercentage.create(parent_id: 6, ptype: 'Jobseeker', key: 'certificate', value: 50)
UserPercentage.create(ptype: 'Jobseeker', key: 'extra', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'whizquiz', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'futuregoal', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'workingenv', value: 10)
UserPercentage.create(ptype: 'Jobseeker', key: 'references', value: 10)



UserPercentage.create(ptype: 'Company', key: 'info', value: 50)
UserPercentage.create(ptype: 'Company', key: 'corporate', value: 10)
UserPercentage.create(ptype: 'Company', key: 'growth', value: 10)
UserPercentage.create(parent_id: 16, ptype: 'Company', key: 'evalution', value: 50)
UserPercentage.create(parent_id: 16, ptype: 'Company', key: 'futuregoal', value: 50)
UserPercentage.create(ptype: 'Company', key: 'achievement', value: 10)
UserPercentage.create(parent_id: 19, ptype: 'Company', key: 'award', value: 50)
UserPercentage.create(parent_id: 19, ptype: 'Company', key: 'certificate', value: 50)
UserPercentage.create(ptype: 'Company', key: 'gallery', value: 10)
UserPercentage.create(ptype: 'Company', key: 'workingenv', value: 10)



UserPercentage.create(ptype: 'Student', key: 'info', value: 20)
UserPercentage.create(ptype: 'Student', key: 'education', value: 40)
UserPercentage.create(parent_id: 25, ptype: 'Student', key: 'education_info', value: 50)
UserPercentage.create(parent_id: 25, ptype: 'Student', key: 'marksheet', value: 40)
UserPercentage.create(parent_id: 25, ptype: 'Student', key: 'project', value: 10)
UserPercentage.create(ptype: 'Student', key: 'achievement', value: 20)
UserPercentage.create(parent_id: 29, ptype: 'Student', key: 'award', value: 50)
UserPercentage.create(parent_id: 29, ptype: 'Student', key: 'certificate', value: 50)
UserPercentage.create(ptype: 'Student', key: 'extra', value: 10)
UserPercentage.create(ptype: 'Student', key: 'futuregoal', value: 10)



UserPercentage.create(ptype: 'Faculty', key: 'info', value: 20)
UserPercentage.create(ptype: 'Faculty', key: 'experience', value: 60)
UserPercentage.create(parent_id: 35, ptype: 'Faculty', key: 'affiliation', value: 30)
UserPercentage.create(parent_id: 35, ptype: 'Faculty', key: 'workshop', value: 30)
UserPercentage.create(parent_id: 35, ptype: 'Faculty', key: 'publication', value: 20)
UserPercentage.create(parent_id: 35, ptype: 'Faculty', key: 'research', value: 20)
UserPercentage.create(ptype: 'Faculty', key: 'achievement', value: 20)
UserPercentage.create(parent_id: 40, ptype: 'Faculty', key: 'award', value: 50)
UserPercentage.create(parent_id: 40, ptype: 'Faculty', key: 'certificate', value: 50)

UserPercentage.create(ptype: 'site', key: 'like', value: 8)
UserPercentage.create(parent_id: 43, ptype: 'site', key: 'like_first', value: 100)
UserPercentage.create(parent_id: 43, ptype: 'site', key: 'like_second', value: 300)
UserPercentage.create(parent_id: 43, ptype: 'site', key: 'like_third', value: 500)
UserPercentage.create(ptype: 'site', key: 'star', value: 8)
UserPercentage.create(parent_id: 43, ptype: 'site', key: 'star_first', value: 100)
UserPercentage.create(parent_id: 43, ptype: 'site', key: 'star_second', value: 300)
UserPercentage.create(parent_id: 43, ptype: 'site', key: 'star_third', value: 500)
UserPercentage.create(ptype: 'site', key: 'updateinfo', value: 8)
UserPercentage.create(parent_id: 48, ptype: 'site', key: 'update_first', value: 10)
UserPercentage.create(parent_id: 48, ptype: 'site', key: 'update_second', value: 30)
UserPercentage.create(parent_id: 48, ptype: 'site', key: 'update_third', value: 50)
UserPercentage.create(ptype: 'site', key: 'share', value: 8)
UserPercentage.create(parent_id: 52, ptype: 'site', key: 'share_first', value: 100)
UserPercentage.create(parent_id: 52, ptype: 'site', key: 'share_second', value: 300)
UserPercentage.create(parent_id: 52, ptype: 'site', key: 'share_third', value: 500)
UserPercentage.create(ptype: 'site', key: 'viewed', value: 8)
UserPercentage.create(parent_id: 56, ptype: 'site', key: 'view_first', value: 100)
UserPercentage.create(parent_id: 56, ptype: 'site', key: 'view_second', value: 300)
UserPercentage.create(parent_id: 56, ptype: 'site', key: 'view_third', value: 500)
UserPercentage.create(ptype: 'site', key: 'marketIQ', value: 15)
UserPercentage.create(parent_id: 60, ptype: 'site', key: 'market_first', value: 100)
UserPercentage.create(parent_id: 60, ptype: 'site', key: 'market_second', value: 300)
UserPercentage.create(parent_id: 60, ptype: 'site', key: 'market_third', value: 500)
UserPercentage.create(ptype: 'site', key: 'stockexchange', value: 35)
UserPercentage.create(parent_id: 64, ptype: 'site', key: 'stock_first', value: 100)
UserPercentage.create(parent_id: 64, ptype: 'site', key: 'stock_second', value: 300)
UserPercentage.create(parent_id: 64, ptype: 'site', key: 'stock_third', value: 500)
UserPercentage.create(ptype: 'site', key: 'profilemeter', value: 10)

user = User.create(email: 'admin@example.com', password: '12345678' , username: 'admin' , role: 'Admin', user_total_per:10 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid, device_type: 'android')

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

Setting.create(site_name: 'Selfie Cv', site_email: 'selfiecv@gmailcom',site_phone: 12345678,site_fax: 1234567,facebook_url:'http://www.facebook.com/selfiecv',twitter_url:'http://www.twitter.com/selfiecv',google_plus_url: 'http://www.googleplus.com/selfiecv', whizquiz_time: 3, marketiq_time: 60)

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

CompanyStock.create(sensex_co: "Argentina",	sensex: "BCBA", currency: "ARS", date_format: "not_available")
CompanyStock.create(sensex_co: "Austria",		sensex: "VIE", currency: "€", date_format: "not_available")
CompanyStock.create(sensex_co: "Australia",	sensex: "ASX", currency: "A$", date_format: "not_available")
CompanyStock.create(sensex_co: "Belgium",		sensex: "EBR", currency: "€", date_format: "not_available")
CompanyStock.create(sensex_co: "Brazil",		sensex: "BVMF", currency: "R$", date_format: "dd/mm/yyyy")
CompanyStock.create(sensex_co: "Canada",		sensex: "CNSX", currency: "CA$", date_format: "DD/MM/YYYY")
CompanyStock.create(sensex_co: "Switzerland",	sensex: "SWX", currency: "CHF", date_format: "dd.mm.yyyy")
CompanyStock.create(sensex_co: "China",		sensex: "SHA", currency: "CN¥", date_format: "yyyy-mm-dd")
CompanyStock.create(sensex_co: "Denmark",		sensex: "CPH", currency: "DKK", date_format: "yyyy-mm-dd")
CompanyStock.create(sensex_co: "Estonia",		sensex: "TAL", currency: "€", date_format: "d.m.yyyy")
CompanyStock.create(sensex_co: "Finland",		sensex: "HEL", currency: "€", date_format: "d.m.yyyy")
CompanyStock.create(sensex_co: "France",		sensex: "EPA", currency: "€", date_format: "dd/mm/yyyy")
CompanyStock.create(sensex_co: "Germany",		sensex: "FRA", currency: "€", date_format: "yyyy-mm-dd")
CompanyStock.create(sensex_co: "Spain",		sensex: "BME", currency: "€", date_format: "dd/mm/(yy)yy")
CompanyStock.create(sensex_co: "Hong Kong",	sensex: "HKG", currency: "HK$", date_format: "(d)d/(m)m/(yy)yy")
CompanyStock.create(sensex_co: "Israel",		sensex: "TLV", currency: "₪", date_format: "dd/mm/yyyy")
CompanyStock.create(sensex_co: "India",		sensex: "BOM", currency: "Rs.", date_format: "dd-mm-yyyy")
CompanyStock.create(sensex_co: "Iceland",		sensex: "ICE", currency: "ISK", date_format: "dd.mm.yyyy")
CompanyStock.create(sensex_co: "Italy",		sensex: "BIT", currency: "€", date_format: "dd/mm/yyyy")
CompanyStock.create(sensex_co: "Japan",		sensex: "TYO", currency: "¥", date_format: "yyyy-mm-dd")
CompanyStock.create(sensex_co: "Korea",		sensex: "KRX", currency: "₩", date_format: "yyyy/mm/dd")
CompanyStock.create(sensex_co: "Lithuania",	sensex: "VSE", currency: "€", date_format: "yyyy-mm-dd")
CompanyStock.create(sensex_co: "Latvia",		sensex: "RSE", currency: "€", date_format: "dd.mm.yyyy")
CompanyStock.create(sensex_co: "Netherlands",	sensex: "AMS", currency: "€", date_format: "dd-mm-(yy) yy")
CompanyStock.create(sensex_co: "New Zealand",	sensex: "NZE", currency: "NZ$", date_format: "not_available")
CompanyStock.create(sensex_co: "Poland",		sensex: "WSE", currency: "PLN", date_format: "dd.mm.yyyy")
CompanyStock.create(sensex_co: "Portugal",	sensex: "ELI", currency: "€", date_format: "dd/mm/yyyy")
CompanyStock.create(sensex_co: "Russia",		sensex: "MCX", currency: "RUB", date_format: "dd.mm.(yy)yy")
CompanyStock.create(sensex_co: "Saudi Arabia",sensex: "TADAWUL", currency: "SAR", date_format: "dd/mm/yyyy")
CompanyStock.create(sensex_co: "Singapore",	sensex: "SGX", currency: "SGD", date_format: "not_available")
CompanyStock.create(sensex_co: "South Africa",sensex: "JSE", currency: "ZAR", date_format: "yyyy/mm/dd")
CompanyStock.create(sensex_co: "Sweden",		sensex: "STO", currency: "SEK", date_format: "yyyy-mm-dd")
CompanyStock.create(sensex_co: "Thailand",	sensex: "BKK", currency: "THB", date_format: "not_available")
CompanyStock.create(sensex_co: "Turkey",		sensex: "IST", currency: "TRY", date_format: "not_available")
CompanyStock.create(sensex_co: "Taiwan",		sensex: "TPE", currency: "NT$", date_format: "yyyy-mm-dd")
CompanyStock.create(sensex_co: "United Kingdom",sensex: "LON", currency: "£", date_format: "dd/mm/yyyy")
CompanyStock.create(sensex_co: "United States",sensex: "NASDAQ", currency: "$", date_format: "mm/dd/yyyy")





