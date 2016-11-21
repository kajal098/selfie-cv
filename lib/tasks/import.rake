namespace :import do
  desc "TODO"
  task users: :environment do
  	User.create!(email: 'trupti@gmail.com', password:'12345678' , username: 'trupti' , role: 'Student' , first_name: 'trupti', country_id: 3) 
	User.create!(email: 'anni@gmail.com', password:'12345678' , username: 'anni' , role: 'Student' , first_name: 'anni', country_id: 3) 
	User.create!(email: 'daisy@gmail.com', password: '12345678' , username: 'daisy' , role: 'Faculty', first_name: 'daisy', country_id: 3)
	User.create!(email: 'jekky@gmail.com', password: '12345678' , username: 'jekky' , role: 'Faculty', first_name: 'jekky', country_id: 3)
	User.create!(email: 'thomas@gmail.com', password: '12345678' , username: 'thomas' , role: 'Jobseeker', first_name: 'thomas', country_id: 3)
	User.create!(email: 'victor@gmail.com', password: '12345678' , username: 'victor' , role: 'Jobseeker', first_name: 'victor', country_id: 3)
	User.create!(email: 'parnel@gmail.com', password: '12345678' , username: 'parnel' , role: 'Company', first_name: 'parnel', country_id: 3)
	User.create!(email: 'kriya@gmail.com', password: '12345678' , username: 'kriya' , role: 'Company', first_name: 'kriya', country_id: 3)
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

	UserCurricular.create(user_id: 2, curricular_type:'talent', team_type:'individual', location:'junagadh', date:'22/11/2011')
	UserCurricular.create(user_id: 3, curricular_type:'talent', team_type:'team', location:'junagadh', date:'22/11/2011')
	UserCurricular.create(user_id: 6, curricular_type:'sports', team_type:'individual', location:'junagadh', date:'22/11/2011')
	UserCurricular.create(user_id: 7, curricular_type:'sports', team_type:'team', location:'jamnagar', date:'22/11/2011')
	
	UserEducation.create(user_id: 6, course_id:3, specialization_id:3,  year:2011, school: 'modi', skill: 'singing')
	UserEducation.create(user_id: 7, course_id:4, specialization_id:4,  year:2011, school: 'vivekanand', skill: 'dancing')
	
	UserEnvironment.create(user_id: 6, env_type: 'like', title: 'title')
	UserEnvironment.create(user_id: 7, env_type: 'dislike', title: 'title')
	UserEnvironment.create(user_id: 8, env_type: 'like', title: 'title')
	UserEnvironment.create(user_id: 9, env_type: 'dislike', title: 'title')

	UserExperience.create(user_id: 4, name: 'zxcvb', exp_type: 'experience', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	UserExperience.create(user_id: 5, name: 'zxcvb', exp_type: 'fresher', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	UserExperience.create(user_id: 6, name: 'zxcvb', exp_type: 'experience', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	UserExperience.create(user_id: 7, name: 'zxcvb', exp_type: 'fresher', start_from: '22/10/2012', working_till: '22/11/2011', designation:'tester')
	
	UserFutureGoal.create(user_id: 2, goal_type: 'life goal', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 3, goal_type: 'life goal', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 6, goal_type: 'life goal', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 7, goal_type: 'financial goal', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 8, goal_type: 'financial goal', title: 'hjure', term_type: 'ghjk')
	UserFutureGoal.create(user_id: 9, goal_type: 'financial goal', title: 'hjure', term_type: 'ghjk')

	UserPreferredWork.create(user_id: 6, ind_name: 'Krishaweb', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')
	UserPreferredWork.create(user_id: 7, ind_name: 'Infosys', functional_name: 'backend',  preferred_designation: 'developer', preferred_location: 'ahmedabad', current_salary: '10000', expected_salary: '20000', time_type: 'fulltime')

	UserReference.create(user_id: 6, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')
	UserReference.create(user_id: 7, title: 'my ref', ref_type: 'individual', from: 'mr.joseph', email: 'jk@gmail.com', contact: '9988776655', date: '22/11/2011', location: 'asxde')

	StudentEducation.create(user_id: 2, standard: 'first',  year:2011, school: 'modi' )
	StudentEducation.create(user_id: 3, standard: 'third',  year:2011, school: 'vivekanand' )

	UserMarksheet.create(user_id: 2, school_name: 'vivekanand school', standard: 'first', grade: 'A', year: 2011)
	UserMarksheet.create(user_id: 3, school_name: 'modi school', standard: 'third', grade: 'C', year: 2011)

	UserProject.create(user_id: 2, title: 'sdfgh', description: 'first')
	UserProject.create(user_id: 3, title: 'qwertyu', description: 'third')

	FacultyAffiliation.create(user_id:4, university:'gtu', collage_name: 'vgec', subject: 'computer', designation: 'chandkheda', join_from: '22/11/2011' )
	FacultyAffiliation.create(user_id:5, university:'gtu', collage_name: 'vgec', subject: 'computer', designation: 'chandkheda', join_from: '22/11/2011' )

	FacultyPublication.create(user_id:4, title:'first pub', description: 'first pub des' )
	FacultyPublication.create(user_id:5, title:'second pub', description: 'second pub des' )

	FacultyResearch.create(user_id:4, title:'first res', description: 'first res des' )
	FacultyResearch.create(user_id:5, title:'second res', description: 'second res des' )

	FacultyWorkshop.create(user_id:4, description:'first workshop des' )
	FacultyWorkshop.create(user_id:5, description:'second workshop des' )

	Graph.create(industry_id:1 , company_stock_id:1 , company_code:'ASD')
	Graph.create(industry_id:2 , company_stock_id:2 , company_code:'QWE')
	Graph.create(industry_id:3 , company_stock_id:3 , company_code:'FGH')
	Graph.create(industry_id:4 , company_stock_id:4 , company_code:'CVB')

  end

  task many_user: :environment do
  	10.times do |i|
	    user = User.new
	    user.email = "user#{i}@example.com"
	    user.username = "User #{i}"
	    user.role = "Jobseeker"
	    user.password = "12345678"
	    user.save
  	end
  end

end
