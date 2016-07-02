if @user

		json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :education_in, :school_name, :year

		json.profile_pic @user.profile_thumb_url

		json.resume @user.resume_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
			
end

if @user_education
	json.educations @user.user_educations do |education|
	  	json.extract! education, :id, :user_id, :course_id, :specialization_id, :year, :school, :skill
	end
		json.edu_created_at @user_education.created_at.to_i
		json.edu_updated_at @user_education.updated_at.to_i
end

if @award
	json.awards @user.awards do |award|
		json.extract! award, :id, :user_id, :name, :description
	end
		json.award_created_at @award.created_at.to_i
		json.award_updated_at @award.updated_at.to_i
end

if @certificate
	json.certificates @user.certificates do |certificate|
		json.extract! certificate, :id, :user_id, :name, :description
	end
		json.certificate_created_at @certificate.created_at.to_i
		json.certificate_updated_at @certificate.updated_at.to_i
end

if @curricular
	json.curriculars @user.user_curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date

		json.file curricular.thumb_url
	end
		json.curricular_created_at @curricular.created_at.to_i
		json.curricular_updated_at @curricular.updated_at.to_i
end