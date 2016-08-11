json.status "Success"

if @users
@all_users = @users.order('created_at DESC')
		json.users @all_users do |user|
				if user.role == "Jobseeker"
						json.extract! user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number
						json.profile user.profile_thumb_url
						json.profile_video user.profile_photo_url
						json.resume user.resume_thumb_url
						json.created_at user.created_at.to_i
						json.updated_at user.updated_at.to_i

					json.usereducation user.user_educations do |edu|
						json.extract! edu, :id, :user_id, :year, :school, :skill, :course_id, :specialization_id
					end

						json.user_resume_per user.user_meter.resume_per.to_i
						json.user_achievement_per user.user_meter.achievement_per.to_i
						json.user_curricular_per user.user_meter.curri_per.to_i
						json.user_lifegoal_per user.user_meter.lifegoal_per.to_i
						json.user_working_environment_per user.user_meter.working_per.to_i
						json.user_reference_per user.user_meter.ref_per.to_i

				elsif user.role == "Company"
						json.extract! user, :id, :username, :role, :company_name, :company_establish_from,  :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id,  :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet
						json.logo user.logo_thumb_url
						json.profile user.company_profile_thumb_url
						json.brochure user.brochure_thumb_url
						json.created_at user.created_at.to_i
						json.updated_at user.updated_at.to_i

						
						json.user_resume_per user.user_meter.resume_per.to_i
						json.user_achievement_per user.user_meter.achievement_per.to_i
						json.user_curricular_per user.user_meter.curri_per.to_i
						json.user_lifegoal_per user.user_meter.lifegoal_per.to_i
						json.user_working_environment_per user.user_meter.working_per.to_i
						json.user_reference_per user.user_meter.ref_per.to_i
				end
		end
end