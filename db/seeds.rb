# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = User.create(email: 'admin@example.com', password: '12345678' , username: 'admin' , role: 'Admin' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'nicolecross1579@gmail.com', password:'12345678' , username: 'nicole' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'daisy@gmail.com', password: '12345678' , username: 'daisy' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'sam@gmail.com', password: '12345678' , username: 'sam' , role: 'Jobseeker' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'parnel@gmail.com', password: '12345678' , username: 'parnel' , role: 'Company' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create(email: 'admin11111@example.com', password: '12345678' , username: 'admin11111' , role: 'Admin' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'nicolecross157911111@gmail.com', password:'12345678' , username: 'nicole11111' , role: 'Student' ) 
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'daisy11111@gmail.com', password: '12345678' , username: 'daisy11111' , role: 'Faculty' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'sam11111@gmail.com', password: '12345678' , username: 'sam11111' , role: 'Jobseeker' )
user.devices << Device.create!(uuid: SecureRandom.uuid , 	registration_id: SecureRandom.uuid)
user = User.create!(email: 'parnel11111@gmail.com', password: '12345678' , username: 'parnel11111' , role: 'Company' )
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

UserAward.create(user_id: 1, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 1, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 2, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 2, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 3, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 3, name:'zxc', award_type:'hju', description:'vbf')
UserAward.create(user_id: 4, name:'abc', award_type:'pqr', description:'xyz')
UserAward.create(user_id: 4, name:'zxc', award_type:'hju', description:'vbf')
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
UserPreferredWork.create(user_id: 4, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
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















