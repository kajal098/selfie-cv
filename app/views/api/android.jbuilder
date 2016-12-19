json.status "Success"

if @update_image
	json.profile_thumb @update_image.profile_thumb_url
	json.profile @update_image.profile_photo_url
	json.back_profile_thumb @update_image.back_profile_thumb_url
	json.back_profile @update_image.back_profile_photo_url
end

if @video
	json.file_thumb @video.thumb_url
	json.file @video.file.url
end

if @user
	if @user.role == 'Jobseeker'

		json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type, :active

		json.country_name @user.stock_country ? @user.stock_country.name : ""

		json.date_format @user.stock_country ? @user.stock_country.date_format : "dd/mm/yyyy"

		json.profile_thumb @user.profile_thumb_url
		json.profile @user.profile_pic.url

		if @user.file_type == ""
			json.resume_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.resume "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			if @user.file_type == "audio"
				json.resume_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			else
				json.resume_thumb @user.resume_thumb_url
			end
			json.resume @user.file.url
		end
		json.back_profile_thumb @user.back_profile_thumb_url
		json.back_profile @user.back_profile.url
		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.resume_per @user.user_meter ? @user.user_meter.resume_info_per.to_i + @user.user_meter.education_per.to_i + @user.user_meter.experience_per.to_i + @user.user_meter.prework_per.to_i  : 0
		json.achievement_per @user.user_meter ? @user.user_meter.award_per.to_i + @user.user_meter.certificate_per.to_i : 0
		json.curri_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.curri_per.to_i, "extra") : 0
		json.future_goal_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.future_goal_per.to_i, "futuregoal") : 0
		json.working_env_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.working_env_per.to_i, "workingenv") : 0
		json.ref_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.ref_per.to_i, "references") : 0
		json.whizquiz_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.whizquiz_per.to_i, "whizquiz") : 0
		json.total_per @user.user_meter ? @user.user_meter.profile_meter_per.to_i : 0

		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count

		json.user_folders @user.user_folders do |user_folder|
			json.extract! user_folder, :id, :folder_id
			json.folder_name user_folder.folder.name
			json.user_favs UserFavourite.where(folder_id: user_folder.folder_id) do |user_fav|
				json.id user_fav.fav_user.id
				json.username user_fav.fav_user.username
			end
		end

	elsif @user.role == 'Company'

		json.User @user, :id, :username, :role, :company_name, :company_establish_from, :company_functional_area, :company_address, :company_zipcode, :company_city, :country_id,  :company_contact, :company_skype_id, :company_website, :company_facebook_link, :file_type,  :company_logo_type, :company_profile_type, :company_brochure_type, :active

		json.CompanyEvalution @user, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures

		
		json.CompanyFutureGoal @user, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet

		json.country_name @user.stock_country ? @user.stock_country.name : ""

		json.date_format @user.stock_country ? @user.stock_country.date_format : "dd/mm/yyyy"

		json.logo_thumb @user.logo_thumb_url
		json.logo @user.company_logo.url		
		json.profile_thumb @user.company_profile_thumb_url
		json.profile @user.company_profile.url
		json.brochure_thumb @user.brochure_thumb_url
		json.brochure @user.company_brochure.url
		json.back_profile_thumb @user.back_profile_thumb_url
		json.back_profile @user.back_profile.url
		json.company_id @user.company ? @user.company_id : ""
		json.company @user.company ? @user.company.name : ""
		json.industry_id @user.industry ? @user.industry_id : ""
		json.industry @user.industry ? @user.industry.name : ""
		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
		
		json.company_info_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.company_info_per.to_i, "info") : 0
		json.corporate_identity_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.corporate_identity_per.to_i, "corporate") : 0
		json.growth_and_goal_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.growth_and_goal_per.to_i, "growth") : 0
		json.achievement_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.achievement_per.to_i, "achievement") : 0
		json.galery_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.galery_per.to_i, "gallery") : 0
		json.working_env_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.working_env_per.to_i, "workingenv") : 0
		json.total_per @user.user_meter ? @user.user_meter.profile_meter_per.to_i : 0

		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count

		json.user_folders @user.user_folders do |user_folder|
			json.extract! user_folder, :id, :folder_id
			json.folder_name user_folder.folder.name
			json.user_favs UserFavourite.where(folder_id: user_folder.folder_id) do |user_fav|
				json.id user_fav.fav_user.id
				json.username user_fav.fav_user.username
			end
		end

	elsif @user.role == 'Student'

		json.User @user, :id, :username, :email, :role, :first_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type, :active

		json.country_name @user.stock_country ? @user.stock_country.name : ""

		json.date_format @user.stock_country ? @user.stock_country.date_format : "dd/mm/yyyy"

		json.profile_thumb @user.profile_thumb_url
		json.profile @user.profile_pic.url

		if @user.file_type == ""
			json.resume_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.resume "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.resume_thumb @user.resume_thumb_url
			json.resume @user.file.url
		end
		
		json.back_profile_thumb @user.back_profile_thumb_url
		json.back_profile @user.back_profile.url
		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.student_basic_info_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.student_basic_info_per.to_i, "info") : 0
		json.student_education_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.student_education_per.to_i, "education") : 0
		json.achievement_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.achievement_per.to_i, "achievement") : 0
		json.curri_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.curri_per.to_i, "extra") : 0
		json.future_goal_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.future_goal_per.to_i, "futuregoal") : 0
		json.total_per @user.user_meter ?  @user.user_meter.profile_meter_per.to_i : 0
		
		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count

	elsif @user.role == 'Faculty'

		json.User @user, :id, :username, :email, :role, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :faculty_work_with_type, :faculty_uni_name, :faculty_subject, :faculty_designation, :faculty_join_from, :file_type, :active

		json.country_name @user.stock_country ? @user.stock_country.name : ""

		json.date_format @user.stock_country ? @user.stock_country.date_format : "dd/mm/yyyy"
		
		json.profile_thumb @user.profile_thumb_url
		json.profile @user.profile_pic.url

		if @user.file_type == ""
			json.resume_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.resume "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.resume_thumb @user.resume_thumb_url
			json.resume @user.file.url
		end
		json.back_profile_thumb @user.back_profile_thumb_url
		json.back_profile @user.back_profile.url
		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.faculty_basic_info_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.faculty_basic_info_per.to_i, "info") : 0
		json.experience_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.experience_per.to_i, "experience") : 0
		json.achievement_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.achievement_per.to_i, "achievement") : 0
		json.total_per @user.user_meter ?  @user.user_meter.profile_meter_per.to_i : 0
		
		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count

	end
end

if @students
	json.students @students do |student|
		json.extract! student, :id, :username, :email
	end
end

if @user_education
		json.extract! @user_education, :id, :user_id, :year, :school, :skill, :course_id, :specialization_id
		json.course @user_education.course.name
		json.specialization @user_education.specialization.name
		json.edu_created_at @user_education.created_at.to_i
		json.edu_updated_at @user_education.updated_at.to_i
end
if @user_educations
	json.user_educations @user_educations.order('created_at DESC') do |education|
		json.extract! education, :id, :user_id, :year, :school, :skill, :course_id, :specialization_id
		json.course education.course.name
		json.specialization education.specialization.name
		json.edu_created_at education.created_at.to_i
		json.edu_updated_at education.updated_at.to_i
	end
end

if @user_experience
	json.date_format @user_experience.user.stock_country ? @user_experience.user.stock_country.date_format : "dd/mm/yyyy"

	json.extract! @user_experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company, :file_type

		if @user_experience.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @user_experience.thumb_url
			json.file @user_experience.file.url
		end

	json.created_at @user_experience.created_at.to_i
	json.updated_at @user_experience.updated_at.to_i
end
if @user_experiences
	json.user_experiences @user_experiences.order('created_at DESC') do |experience|

	json.date_format experience.user.stock_country ? experience.user.stock_country.date_format : "dd/mm/yyyy"

		json.extract! experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company, :file_type
		if experience.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb experience.thumb_url
			json.file experience.file.url
		end
		json.exp_created_at experience.created_at.to_i
		json.exp_updated_at experience.updated_at.to_i
	end
end

if @user_preferred_work
	json.extract! @user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type
	json.created_at @user_preferred_work.created_at.to_i
	json.updated_at @user_preferred_work.updated_at.to_i
end

if @user_preferred_works
	json.user_preferred_works @user_preferred_works.order('created_at DESC') do |user_preferred_work|
		json.extract! user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type
		json.created_at user_preferred_work.created_at.to_i
		json.updated_at user_preferred_work.updated_at.to_i
	end
end






if @award
	json.extract! @award, :id, :user_id, :name, :description, :file_type
		if @award.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @award.thumb_url
			json.file @award.file.url
		end
	json.created_at @award.created_at.to_i
	json.updated_at @award.updated_at.to_i
end

if @user_awards
	json.awards @user_awards.order('created_at DESC') do |award|
		json.extract! award, :id, :user_id, :name, :description, :file_type
		if award.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb award.thumb_url
			json.file award.file.url
		end
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
	end
end

if @certificate
	json.extract! @certificate, :id, :user_id, :certificate_type, :name, :year, :file_type
	if @certificate.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @certificate.thumb_url
			json.file @certificate.file.url
		end
	json.created_at @certificate.created_at.to_i
	json.updated_at @certificate.updated_at.to_i
end
if @user_certificates
	json.certificates @user_certificates.order('created_at DESC') do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year, :file_type
		if certificate.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb certificate.thumb_url
			json.file certificate.file.url
		end
		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
	end
end

if @curricular
	json.extract! @curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date, :file_type
	if @curricular.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @curricular.thumb_url
			json.file @curricular.file.url
		end
	json.created_at @curricular.created_at.to_i
	json.updated_at @curricular.updated_at.to_i
end
if @user_curriculars
	json.user_curriculars @user_curriculars.order('created_at DESC') do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date, :file_type
		if curricular.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb curricular.thumb_url
			json.file curricular.file.url
		end
		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
	end
end

if @future_goal
	json.extract! @future_goal, :id, :user_id, :goal_type, :title, :term_type, :file_type
	if @future_goal.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @future_goal.thumb_url
			json.file @future_goal.file.url
		end
	json.created_at @future_goal.created_at.to_i
	json.updated_at @future_goal.updated_at.to_i
end
if @user_future_goals
	json.user_future_goals @user_future_goals.order('created_at DESC') do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type, :file_type
		if future_goal.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb future_goal.thumb_url
			json.file future_goal.file.url
		end
		json.future_goal_created_at future_goal.created_at.to_i
		json.future_goal_updated_at future_goal.updated_at.to_i
	end
end

if @environment
	json.extract! @environment, :id, :user_id, :env_type, :title, :text_field, :file_type, :text_field
	if @environment.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @environment.thumb_url
			json.file @environment.file.url
		end
	json.created_at @environment.created_at.to_i
	json.updated_at @environment.updated_at.to_i
end
if @user_working_environments
	json.user_working_environments @user_working_environments.order('created_at DESC') do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title, :text_field, :file_type, :text_field
		if environment.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb environment.thumb_url
			json.file environment.file.url
		end
		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
	end
end

if @reference
	json.extract! @reference, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location, :text_field, :file_type
	if @reference.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @reference.thumb_url
			json.file @reference.file.url
		end
	json.created_at @reference.created_at.to_i
	json.updated_at @reference.updated_at.to_i
end
if @user_references
	json.user_references @user_references.order('created_at DESC') do |ref|
		json.extract! ref, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location, :text_field, :file_type
		if ref.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb ref.thumb_url
			json.file ref.file.url
		end
		json.ref_created_at ref.created_at.to_i
		json.ref_updated_at ref.updated_at.to_i
	end
end

if @courses
	@all_courses = @courses.order('created_at DESC')
	json.courses @all_courses do |course|
		json.extract! course, :id, :name
	end
end

if @industries
	@all_industries = @industries.order('created_at DESC')
	json.industries @all_industries do |industry|
		json.extract! industry, :id, :name
	end
end

if @companies
	@all_companies = @companies.order('created_at DESC')
	json.companies @all_companies do |company|
		json.extract! company, :id, :name
	end
end

if @specializations
	@all_specializations = @specializations.order('created_at DESC')
	json.specializations @all_specializations do |specialization|
		json.extract! specialization, :id, :name
	end
end

if @stock_countries
	json.companystocks @stock_countries do |coun|
		json.id coun.id
		json.country coun.name
	end
end

if @basic_info
	json.BasicInfoOfStudent @basic_info, :id, :username, :email, :role, :first_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :country_id

	json.country_name @basic_info.stock_country ? @basic_info.stock_country.name : ""

	json.date_format @basic_info.stock_country ? @basic_info.stock_country.date_format : "dd/mm/yyyy"
	
	if @basic_info.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @basic_info.resume_thumb_url
			json.file @basic_info.file.url
		end

	json.student_basic_info_per @basic_info.user_meter ? @basic_info.user_meter.student_basic_info_per.to_i : 0
	json.student_education_per @basic_info.user_meter ? @basic_info.user_meter.student_education_per.to_i : 0
	json.achievement_per @basic_info.user_meter ? @basic_info.user_meter.achievement_per.to_i : 0
	json.curri_per @basic_info.user_meter ? @basic_info.user_meter.curri_per.to_i : 0
	json.future_goal_per @basic_info.user_meter ? @basic_info.user_meter.future_goal_per.to_i : 0
	json.total_per @basic_info.user_meter ? @basic_info.user_meter.profile_meter_per.to_i : 0
	json.created_at @basic_info.created_at.to_i
	json.updated_at @basic_info.updated_at.to_i
end

if @student_education
	json.extract! @student_education, :id, :user_id, :standard, :school, :year
	json.edu_created_at @student_education.created_at.to_i
	json.edu_updated_at @student_education.updated_at.to_i
end

if @student_educations
	json.student_educations @student_educations.order('created_at DESC') do |education|
		json.extract! education, :id, :user_id, :standard, :school, :year
		json.edu_created_at education.created_at.to_i
		json.edu_updated_at education.updated_at.to_i
	end
end

if @student_marksheet
	json.extract! @student_marksheet, :id, :user_id, :school_name, :standard, :grade, :year	, :file_type
	if @student_marksheet.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @student_marksheet.thumb_url
			json.file @student_marksheet.file.url
		end
	json.marksheet_created_at @student_marksheet.created_at.to_i
	json.marksheet_updated_at @student_marksheet.updated_at.to_i
end

if @student_marksheets
	json.student_marksheets @student_marksheets.order('created_at DESC') do |marksheet|
		json.extract! marksheet, :id, :user_id, :school_name, :standard, :grade, :year	, :file_type
		if marksheet.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb marksheet.thumb_url
			json.file marksheet.file.url	
		end
		json.marksheet_created_at marksheet.created_at.to_i
		json.marksheet_updated_at marksheet.updated_at.to_i
	end
end

if @student_project
	json.extract! @student_project, :id, :user_id, :title, :description, :file_type
	if @student_project.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @student_project.thumb_url
			json.file @student_project.file.url
		end
	json.project_created_at @student_project.created_at.to_i
	json.project_updated_at @student_project.updated_at.to_i
end

if @student_projects
	json.student_projects @student_projects.order('created_at DESC') do |project|
		json.extract! project, :id, :user_id, :title, :description, :file_type
		if project.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb project.thumb_url
			json.file project.file.url
		end
		json.project_created_at project.created_at.to_i
		json.project_updated_at project.updated_at.to_i
	end
end

if @faculty_affiliation
	json.extract! @faculty_affiliation, :id, :user_id, :university,:collage_name,:subject,:designation,:join_from, :join_till, :file_type
	if @faculty_affiliation.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @faculty_affiliation.thumb_url
			json.file @faculty_affiliation.file.url
		end
	json.affiliation_created_at @faculty_affiliation.created_at.to_i
	json.affiliation_updated_at @faculty_affiliation.updated_at.to_i
end

if @faculty_affiliations
	json.faculty_affiliations @faculty_affiliations.order('created_at DESC') do |affiliation|
		json.extract! affiliation, :id, :user_id, :university,:collage_name,:subject,:designation,:join_from, :join_till, :file_type
		if affiliation.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb affiliation.thumb_url
			json.file affiliation.file.url
		end
		json.affiliation_created_at affiliation.created_at.to_i
		json.affiliation_updated_at affiliation.updated_at.to_i
	end
end

if @faculty_workshop
	json.extract! @faculty_workshop, :id, :user_id, :description, :file_type
	if @faculty_workshop.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @faculty_workshop.thumb_url
			json.file @faculty_workshop.file.url
		end
	json.workshop_created_at @faculty_workshop.created_at.to_i
	json.workshop_updated_at @faculty_workshop.updated_at.to_i
end

if @faculty_workshops
	json.faculty_workshops @faculty_workshops.order('created_at DESC') do |workshop|
		json.extract! workshop, :id, :user_id, :description, :file_type
		if workshop.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb workshop.thumb_url
			json.file workshop.file.url
		end
		json.workshop_created_at workshop.created_at.to_i
		json.workshop_updated_at workshop.updated_at.to_i
	end
end

if @faculty_publication
	json.extract! @faculty_publication, :id, :user_id, :title, :description, :file_type
	if @faculty_publication.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @faculty_publication.thumb_url
			json.file @faculty_publication.file.url
		end
	json.publication_created_at @faculty_publication.created_at.to_i
	json.publication_updated_at @faculty_publication.updated_at.to_i
end

if @faculty_publications
	json.faculty_publications @faculty_publications.order('created_at DESC') do |publication|
		json.extract! publication, :id, :user_id, :title, :description, :file_type
		if publication.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb publication.thumb_url
			json.file publication.file.url
		end
		json.publication_created_at publication.created_at.to_i
		json.publication_updated_at publication.updated_at.to_i
	end
end

if @faculty_research
	json.extract! @faculty_research, :id, :user_id, :title, :description
	if @faculty_research.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb @faculty_research.thumb_url
			json.file @faculty_research.file.url
		end
	json.research_created_at @faculty_research.created_at.to_i
	json.research_updated_at @faculty_research.updated_at.to_i
end

if @faculty_researches
	json.faculty_researches @faculty_researches.order('created_at DESC') do |research|
		json.extract! research, :id, :user_id, :title, :description
		if research.file_type == ""
			json.file_thumb "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
			json.file "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			json.file_thumb research.thumb_url
			json.file research.file.url
		end
		json.research_created_at research.created_at.to_i
		json.research_updated_at research.updated_at.to_i
	end
end
