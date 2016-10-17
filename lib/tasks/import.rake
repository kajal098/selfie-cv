namespace :import do
  desc "TODO"
  task users: :environment do
  	User.create!(email: 'trupti@gmail.com', password:'12345678' , username: 'trupti' , role: 'Student' ) 
	User.create!(email: 'anni@gmail.com', password:'12345678' , username: 'anni' , role: 'Student' ) 
	User.create!(email: 'daisy@gmail.com', password: '12345678' , username: 'daisy' , role: 'Faculty' )
	User.create!(email: 'jekky@gmail.com', password: '12345678' , username: 'jekky' , role: 'Faculty' )
	User.create!(email: 'thomas@gmail.com', password: '12345678' , username: 'thomas' , role: 'Jobseeker' )
	User.create!(email: 'victor@gmail.com', password: '12345678' , username: 'victor' , role: 'Jobseeker' )
	User.create!(email: 'parnel@gmail.com', password: '12345678' , username: 'parnel' , role: 'Company' )
	User.create!(email: 'kriya@gmail.com', password: '12345678' , username: 'kriya' , role: 'Company' )
  end

  desc "TODO"
  task user_stuff: :environment do
  	UserAward.create(user_id: 2, name:'abc', award_type:'pqr', description:'xyz')
  	UserAward.create(user_id: 3, name:'abc', award_type:'pqr', description:'xyz')
	UserAward.create(user_id: 4, name:'sss', award_type:'sas', description:'aaa')
	UserAward.create(user_id: 5, name:'abc', award_type:'pqr', description:'xyz')
	UserAward.create(user_id: 6, name:'abc', award_type:'pqr', description:'xyz')
	UserAward.create(user_id: 7, name:'abc', award_type:'pqr', description:'xyz')
	UserAward.create(user_id: 8, name:'abc', award_type:'pqr', description:'xyz')
	UserAward.create(user_id: 9, name:'abc', award_type:'pqr', description:'xyz')

	UserCertificate.create(user_id: 2,name:'mno', certificate_type:'jkl', year:2011)
	UserCertificate.create(user_id: 3,name:'mno', certificate_type:'jkl', year:2011)
	UserCertificate.create(user_id: 4,name:'mno', certificate_type:'jkl', year:2011)
	UserCertificate.create(user_id: 5,name:'mno', certificate_type:'jkl', year:2011)
	UserCertificate.create(user_id: 6,name:'mno', certificate_type:'jkl', year:2011)
	UserCertificate.create(user_id: 7,name:'mno', certificate_type:'jkl', year:2011)
	UserCertificate.create(user_id: 8,name:'mno', certificate_type:'jkl', year:2011)
	UserCertificate.create(user_id: 9,name:'mno', certificate_type:'jkl', year:2011)

	UserCurricular.create(user_id: 2, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
	UserCurricular.create(user_id: 3, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
	UserCurricular.create(user_id: 6, curricular_type:'vcd', team_type:'cds', location:'junagadh', date:'22/11/2011')
	UserCurricular.create(user_id: 7, curricular_type:'xyz', team_type:'abc', location:'jamnagar', date:'22/11/2011')
	
	UserEducation.create(user_id: 6, course_id:3, specialization_id:3,  year:2011, school: 'modi', skill: 'singing')
	UserEducation.create(user_id: 7, course_id:4, specialization_id:4,  year:2011, school: 'vivekanand', skill: 'dancing')
	
	UserEnvironment.create(user_id: 6, env_type: 'qwert', title: 'title')
	UserEnvironment.create(user_id: 7, env_type: 'qwert', title: 'title')
	UserEnvironment.create(user_id: 8, env_type: 'qwert', title: 'title')
	UserEnvironment.create(user_id: 9, env_type: 'qwert', title: 'title')

	UserExperience.create(user_id: 4, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	UserExperience.create(user_id: 5, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	UserExperience.create(user_id: 6, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	UserExperience.create(user_id: 7, name: 'zxcvb', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	
	UserFutureGoal.create(user_id: 2, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 3, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 6, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 7, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 8, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 9, goal_type: 'zasdew', title: 'hjure', term_type: 'ghjk')

	UserPreferredWork.create(user_id: 6, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
	UserPreferredWork.create(user_id: 7, ind_name: 'Infosys', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')

	UserReference.create(user_id: 6, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
	UserReference.create(user_id: 7, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')

	StudentEducation.create(user_id: 2, standard: 'abcdefg',  year:2011, school: 'modi' )
	StudentEducation.create(user_id: 3, standard: 'abcdefg',  year:2011, school: 'vivekanand' )

	UserMarksheet.create(user_id: 2, school_name: 'sdfgh', standard: 'first', grade: 'A', year: 2011)
	UserMarksheet.create(user_id: 3, school_name: 'qwertyu', standard: 'third', grade: 'C', year: 2011)

	UserProject.create(user_id: 2, title: 'sdfgh', description: 'first')
	UserProject.create(user_id: 3, title: 'qwertyu', description: 'third')

	FacultyAffiliation.create(user_id:4, university:'gtu', collage_name: 'vgec', subject: 'computer', designation: 'chandkheda', join_from: '22/11/2011' )
	FacultyAffiliation.create(user_id:5, university:'gtu', collage_name: 'vgec', subject: 'computer', designation: 'chandkheda', join_from: '22/11/2011' )

	FacultyPublication.create(user_id:4, title:'abcdefghijklmnopqrstuvwxyz', description: 'abcdefghijklmnopqrstuvwxyz' )
	FacultyPublication.create(user_id:5, title:'abcdefghijklmnopqrstuvwxyz', description: 'abcdefghijklmnopqrstuvwxyz' )

	FacultyResearch.create(user_id:4, title:'abcdefghijklmnopqrstuvwxyz', description: 'abcdefghijklmnopqrstuvwxyz' )
	FacultyResearch.create(user_id:5, title:'abcdefghijklmnopqrstuvwxyz', description: 'abcdefghijklmnopqrstuvwxyz' )

	FacultyWorkshop.create(user_id:4, description:'abcdefghijklmnopqrstuvwxyz' )
	FacultyWorkshop.create(user_id:5, description:'abcdefghijklmnopqrstuvwxyz' )

	Group.create(name: 'daisygroup', slug: 'daisygroup', code: 123456 )
	Group.create(name: 'jekkygroup', slug: 'jekkygroup', code: 123456 )
	Group.create(name: 'angelagroup', slug: 'angelagroup', code: 123456 )
	Group.create(name: 'dianagroup', slug: 'dianagroup', code: 123456 )

  end

end
