# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: 'admin@example.com', password: '12345678' , username: 'admin' , role: 'Admin' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create(email: 'michel@example.com', password: '12345678' , username: 'michel' , role: 'Admin' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

user = User.create!(email: 'trupti@gmail.com', password:'12345678' , username: 'trupti' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'anni@gmail.com', password:'12345678' , username: 'anni' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'julia@gmail.com', password:'12345678' , username: 'julia' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'mary@gmail.com', password:'12345678' , username: 'mary' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

user = User.create!(email: 'daisy@gmail.com', password: '12345678' , username: 'daisy' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'jekky@gmail.com', password: '12345678' , username: 'jekky' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'angela@gmail.com', password: '12345678' , username: 'angela' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'diana@gmail.com', password: '12345678' , username: 'diana' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)

user = User.create!(email: 'gunja@gmail.com', password:'12345678' , username: 'gunja' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655 ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'sam@gmail.com', password: '12345678' , username: 'sam' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'riya@gmail.com', password: '12345678' , username: 'riya' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'nicolecross1579@gmail.com', password: '12345678' , username: 'nicole' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'thomas@gmail.com', password: '12345678' , username: 'thomas' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'victor@gmail.com', password: '12345678' , username: 'victor' , role: 'Jobseeker', first_name: 'sam', middle_name: 'deo', last_name: 'jacson', city: 'pune', address: 'street 4,near community hall', nationality: "Indian", contact_number: 9988776655 )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)


user = User.create!(email: 'parnel@gmail.com', password: '12345678' , username: 'parnel' , role: 'Company' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'kriya@gmail.com', password: '12345678' , username: 'kriya' , role: 'Company' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'niya@gmail.com', password: '12345678' , username: 'niya' , role: 'Company' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'abc@gmail.com', password: '12345678' , username: 'abc' , role: 'Company' )
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

UserMeter.create(user_id: 1, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 2, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 3, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 4, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 5, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 6, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 7, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 8, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 9, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 10, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 11, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 12, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 13, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 14, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 15, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 16, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 17, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 18, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 19, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)
UserMeter.create(user_id: 20, resume_per:0, achievement_per:0, curri_per:0, lifegoal_per:0, working_per:0, ref_per:0)


UserAward.create(user_id: 1, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 1, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 2, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 2, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 3, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 3, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 4, name:'School Award', award_type:'Award', description:'I got this in 8th standarad')
UserAward.create(user_id: 4, name:'Drawing Award', award_type:'Achievement', description:'This one is my favourite.!')
UserAward.create(user_id: 5, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 5, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 6, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 6, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 7, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 7, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 8, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 8, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 9, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 9, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 10, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 10, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 11, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 11, name:'zxc', award_type:'hju', description:'vbf')

UserCertificate.create(user_id: 1,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 1,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 2,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 2,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 3,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 3,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 4,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 4,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 5,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 5,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 6,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 6,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 7,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 7,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 8,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 8,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 9,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 9,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 10,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 10,name:'ght', certificate_type:'hdr', year:2011)
UserCertificate.create(user_id: 11,name:'mno', certificate_type:'jkl', year:2011)
UserCertificate.create(user_id: 11,name:'ght', certificate_type:'hdr', year:2011)

UserCurricular.create(user_id: 1, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 1, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 2, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 2, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 3, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 3, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 4, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 4, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 5, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 5, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 6, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 6, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 7, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 7, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 8, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 8, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 9, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 9, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 10, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 10, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
UserCurricular.create(user_id: 11, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
UserCurricular.create(user_id: 11, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')

UserEducation.create(user_id: 1, course_id:1, specialization_id:1,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 1, course_id:1, specialization_id:1,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 2, course_id:2, specialization_id:2,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 2, course_id:2, specialization_id:2,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 3, course_id:3, specialization_id:3,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 3, course_id:3, specialization_id:3,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 4, course_id:4, specialization_id:4,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 4, course_id:4, specialization_id:4,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 5, course_id:5, specialization_id:5,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 5, course_id:5, specialization_id:5,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 6, course_id:6, specialization_id:6,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 6, course_id:6, specialization_id:6,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 7, course_id:7, specialization_id:7,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 7, course_id:7, specialization_id:7,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 8, course_id:8, specialization_id:8,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 8, course_id:8, specialization_id:8,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 9, course_id:9, specialization_id:9,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 9, course_id:9, specialization_id:9,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 10, course_id:10, specialization_id:10,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 10, course_id:10, specialization_id:10,  year:2011, school: 'vivekanand', skill: 'dancing')
UserEducation.create(user_id: 11, course_id:11, specialization_id:11,  year:2011, school: 'modi', skill: 'singing')
UserEducation.create(user_id: 11, course_id:11, specialization_id:11,  year:2011, school: 'vivekanand', skill: 'dancing')

UserEnvironment.create(user_id: 1, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 1, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 2, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 2, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 3, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 3, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 4, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 4, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 5, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 5, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 6, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 6, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 7, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 7, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 8, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 8, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 9, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 9, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 11, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 11, env_type: 'cvfds', title: 'dfgtr')
UserEnvironment.create(user_id: 11, env_type: 'qwert', title: 'title')
UserEnvironment.create(user_id: 11, env_type: 'cvfds', title: 'dfgtr')

UserExperience.create(user_id: 1, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 1, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 2, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 2, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 3, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 3, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 4, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 4, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 5, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 5, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 6, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 6, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 7, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 7, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 8, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 8, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 9, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 9, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 10, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 10, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')
UserExperience.create(user_id: 11, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
UserExperience.create(user_id: 11, name: 'sade', start_from: '22/10/2012', working_till: '22/11/2011', designation:'dev')

UserFutureGoal.create(user_id: 1, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 1, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 2, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 2, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 3, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 3, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 4, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 4, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 5, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 5, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 6, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 6, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 7, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 7, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 8, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 8, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 9, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 9, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 10, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 10, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')
UserFutureGoal.create(user_id: 11, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
UserFutureGoal.create(user_id: 11, goal_type: 'asdf', title: 'fgtr', term_type: 'ghyt')

UserPreferredWork.create(user_id: 1, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 1, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 2, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 2, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 3, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 3, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 4, ind_name: 'Infosys', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 4, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 5, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 5, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 6, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 6, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 7, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 7, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 8, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 8, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 9, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 9, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 10, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 10, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 11, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
UserPreferredWork.create(user_id: 11, ind_name: 'Transenergy', functional_name: 'frontend',  preferred_designation: 'hr', preferred_location: 'rajkot', current_salary: '20000', expected_salary: '30000', time_type: 'fulltime')

UserReference.create(user_id: 1, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 1, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 2, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 2, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 3, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 3, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 4, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 4, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 5, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 5, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 6, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 6, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 7, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 7, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 8, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 8, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 9, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 9, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 10, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 10, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')
UserReference.create(user_id: 11, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
UserReference.create(user_id: 11, title: 'own ref', ref_type: 'company', from: 'miss.anna', email: 'one@gmail.com', contact: '1234567890', date: '30/11/2011', location: 'zawer')



Setting.create(resume_per: 40, achievement_per: 10, curricular_per: 10, whizquiz_per: 10, future_goal_per: 10, working_env_per: 10,reference_per: 10,site_name: 'Selfie Cv', site_email: 'selfiecv@gmailcom',site_phone: 12345678,site_fax: 1234567,facebook_url:'http://www.facebook.com/selfiecv',twitter_url:'http://www.twitter.com/selfiecv',google_plus_url: 'http://www.googleplus.com/selfiecv')











