require 'api_logger'
class SelfiecvIos < Grape::API
	use ApiLogger
	version 'ios', using: :path
	format :json
	formatter :json, Grape::Formatter::Jbuilder
	helpers do
		def clean_params(params)
			ActionController::Parameters.new(params)
		end
		def current_device
			Device.find_by token: params[:token]
		end
		def current_user
			current_device.try(:user)
		end
		def authenticate!
			error! 'Unauthorized', 401 unless params[:token] =~ UUID_REGEX
			error! 'Unauthorized', 401 unless current_user
		end
		def build_query
    ret = { 
      query: {
        filtered: { 
          query: {
            bool: { must: [] }
            },  
          filter: { bool: { must: [] } },
          }
        },
      post_filter: { bool: { must: [] } },
      # aggs: {
      #   category:{
      #     filter: aggregation_filters(:category),
      #     aggs: {
      #       category: { terms: { field: :category } } 
      #       }
      #     },
      #   diet: {
      #     filter: aggregation_filters(:diet),
      #     aggs: {
      #       diet: { terms: { field: :diet } }
      #     }
      #   },
      #   age:{
      #     filter: aggregation_filters(:age),
      #     aggs: { 
      #         price: { range: { 
      #             field: :price,
      #             keyed: true,
      #             ranges: [
      #               { key: '0-25', to: 25 },
      #               { key: '25-50', from: 25, to: 50 },
      #               { key: '50-75', from: 50, to: 75 },
      #               { key: '75-all', from: 75 }
      #               ] 
      #             } }
      #       }
      #     }
      #   }
      }

    ret[:query][:filtered][:filter][:bool][:must] << { term: { role: params[:role] } }

    unless params[:q].blank?
      ret[:query][:filtered][:query][:bool][:must] << { multi_match: {
        query: params[:q],
        fields: [:specializations],
        type: :phrase_prefix
        } 
      }
    end

    unless params[:course].blank?
      ret[:query][:filtered][:query][:bool][:must] << { multi_match: {
        query: params[:course],
        fields: [:courses],
        type: :phrase_prefix
        } 
      }
    end

    unless params[:country_id].blank?
      ret[:query][:filtered][:filter][:bool][:must]  << { term: { country_id: params[:country_id] } }
    end

    unless params[:gender].blank?
      ret[:query][:filtered][:filter][:bool][:must]  << { term: { gender: params[:gender] } }
    end

    ret[:post_filter][:bool][:must] = aggregation_filters(:all)

    ret
  end

  def aggregation_filters term
    ret = {bool: { must: [] }}

    unless params[:job_type].blank?
      ret[:bool][:must] << { terms: { job_type: Array(params[:job_type]) } }
    end

    # unless params[:category].blank?
    #   ret[:bool][:must] << { terms: { category: Array(params[:category]) } }
    # end

    # unless params[:diet].blank?
    #   ret[:bool][:must] << { terms: { diet: Array(params[:diet]) } }
    # end

    # unless params[:price].blank?
    #   should = []
    #   Array(params[:price]).each do |price|
    #     gte, lte = price.split('-')
    #     if lte and gte
    #       if lte == 'all'
    #         should << { range: { price: { gte: gte } } }
    #       else
    #         should << { range: { price: { gte: gte, lte: lte } } }
    #       end
    #     end

    #   end
    #   ret[:bool][:must] << { bool: { should: should } }
    # end

    unless params[:age].blank?
      should = []
      Array(params[:age]).each do |age|
        gte, lte = age.split('-')
        if lte and gte
          if lte == 'all'
            should << { range: { age: { gte: gte } } }
          else
            should << { range: { age: { gte: gte, lte: lte } } }
          end
        end
      end
    ret[:bool][:must] << { bool: { should: should } }
    end

    unless params[:salary].blank?
      should = []
      Array(params[:salary]).each do |salary|
        gte, lte = salary.split('-')
        if lte and gte
          if lte == 'all'
            should << { range: { salary: { gte: gte } } }
          else
            should << { range: { salary: { gte: gte, lte: lte } } }
          end
        end
      end
    ret[:bool][:must] << { bool: { should: should } }
    end

    unless params[:views].blank?
      should = []
      Array(params[:views]).each do |view|
        gte, lte = view.split('-')
        if lte and gte
          if lte == 'all'
            should << { range: { views: { gte: gte } } }
          else
            should << { range: { views: { gte: gte, lte: lte } } }
          end
        end
      end
    ret[:bool][:must] << { bool: { should: should } }
    end

    unless params[:rating].blank?
      should = []
      Array(params[:rating]).each do |rate|
        gte, lte = rate.split('-')
        if lte and gte
          if lte == 'all'
            should << { range: { rating: { gte: gte } } }
          else
            should << { range: { rating: { gte: gte, lte: lte } } }
          end
        end
      end
    ret[:bool][:must] << { bool: { should: should } }
    end
    
    ret
  end
	end
#--------------------------------devices start----------------------------------#
resources :devices do
	desc 'Register device after notification service subscription'
	params do
		requires :uuid, type: String, regexp: UUID_REGEX
		optional :registration_id, type: String
		requires :device_type, type: String
	end
	post :register do
		@device = Device.find_or_initialize_by uuid: params[:uuid]
		@device.registration_id = params[:registration_id]
		@device.device_type = params[:device_type]
		@device.renew_token
		error! @device.errors.full_messages.join(', '), 422 unless @device.save
		@device.ensure_duplicate_registrations
		{ token: @device.token }
	end
	desc 'Deactivate device for notifications'
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :unsubscribe do
		@device = Device.find_by token: params[:token]
		@device.registration_id = nil
		@device.save
		{ token: @device.token }
	end
end
#--------------------------------devices end----------------------------------#
#--------------------------------member start----------------------------------#
resources :member do 
	desc 'Register User with primary details'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :username
		requires :email
		requires :password
		requires :password_confirmation
		requires :role
	end
	post :register, jbuilder: 'ios' do
		@user = User.new clean_params(params).permit(:username, :email, :password, :password_confirmation, :role)
		error! 'Device not registered',422 unless current_device
		error! 'password not matched', 200 if params[:password] != params[:password_confirmation]
		error! @user.errors.full_messages.join(', '), 422 unless @user.save
		UserMailer.welcome(@user, @password).deliver_now
		status 200
		if @user.role == 'Jobseeker' || @user.role == 'Company'
			@names = ['my favourite','it', 'politics', 'sports']
			@names.each do |name|
				@folder = Folder.new name: name, default_status: true
				error! @user.errors.full_messages.join(', '),422 unless @folder.save
				@user_folder = UserFolder.new user_id: @user.id, folder_id: @folder.id
				error! @user.errors.full_messages.join(', '),422 unless @user_folder.save
			end
		end
	end
	desc 'User login with email and password'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :username
		requires :password
		requires :role
	end
	post :login , jbuilder: 'ios' do
		@user = User.find_by username: params[:username]
		error!({error: 'User not found', status: ''}, 422) unless @user
		if @user.active == false		
			error!({error: 'Your account has been deactivated', status: 'Fail'}, 422)
		else
			error!({error: 'Device not registered', status: ''}, 422) unless current_device			
			error!({error: 'authentication failed', status: ''}, 422) unless @user.role == params[:role]
			error!({error: 'Wrong username or password', status: ''}, 422) unless @user.valid_password? params[:password]
			current_device.update_column :user_id, @user.id
		end
	end
	desc 'Send reset password token'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :email
		requires :role
	end
	post :reset_code do
		if
			@user = User.where(email: params[:email]).where(role: User::ROLES[params[:role]]).first
			error! 'User not found',422 unless @user
			@user.update_column :reset_code, (SecureRandom.random_number*1000000).to_i
			UserMailer.send_reset_code(@user).deliver_now
			@user.reset_code
		else
			error! "User does not exist.", 422
		end
	end
	desc 'Resend reset password token'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :email
		requires :role
	end
	post :resend_reset_code do
		if
			@user = User.where(email: params[:email]).where(role: User::ROLES[params[:role]]).first
			error! 'User not found',422 unless @user
			@code = @user.reset_code
			UserMailer.send_reset_code(@user).deliver_now
			@user.reset_code
		else
			error! "User does not exist.", 422
		end
	end
	desc 'Reset Password'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :code, type: String
		requires :password, type: String
		requires :password_confirmation, type: String
	end
	post :reset_password do
		@user = User.find_by_reset_code(params[:code])
		error! "Wrong reset code.", 422 unless @user
		error! "Password not same as previous password", 422 if @user.valid_password?(params[:password])
		error! 'password not matched', 200 if params[:password] != params[:password_confirmation]
		@user.attributes = clean_params(params).permit(:password, :password_confirmation)
		error! @user.errors.full_messages.join(', '), 422 unless @user.save
		{}
	end
	desc 'Change Password'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :current_password, type: String
		requires :password, type: String
		requires :password_confirmation, type: String
	end
	post :change_password , jbuilder: 'ios' do
		authenticate!
		@user = current_user
		error! "Current password is wrong.", 422 unless @user.valid_password? params[:current_password]
		error! "Password not same as previous password", 422 if @user.valid_password?(params[:password])
		error! 'password not matched', 200 if params[:password] != params[:password_confirmation]
		@user.attributes = clean_params(params).permit(:password, :password_confirmation)
		error! @user.errors.full_messages.join(', '), 422 unless @user.save
	end
	desc 'Deactivate User Account'
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :deactivate_user_account do
		authenticate!
		@user = current_user
		@user.active = false
		@user.save
		UserMailer.send_ac_deactivate_mail(@user).deliver_now
		status 200
	end
	desc 'Reactivate User Account'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :username
	end
	post :reactivate_user_account do
		@user = User.find_by_username(params[:username])
		error! 'Wrong delete code.',422 unless @user 
		@user.active = true
		@user.save
		UserMailer.send_ac_reactivate_mail(@user).deliver_now
		status 200
	end
	desc 'All stuff'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :all_stuff , jbuilder: 'ios_all_stuff' do
		authenticate!
		@user_stuff = User.find params[:user_id]
		error! 'User not found',422 unless @user_stuff      
	end
	desc 'View Another Users All stuff'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :view_another_user_all_stuff , jbuilder: 'ios_another_stuff' do
		authenticate!
		@user_stuff = User.find params[:user_id]
		error!({error: 'User not found', status: 'Fail'}, 200) unless @user_stuff      
	end
end
#--------------------------------member end----------------------------------#
#--------------------------------member profile start----------------------------------#
resources :member_profile do 
	before { authenticate! }
	desc 'User Resume'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :title
		requires :first_name
		optional :middle_name
		requires :last_name
		requires :gender
		requires :date_of_birth 
		requires :nationality 
		requires :address 
		requires :city
		requires :zipcode
		requires :country_id
		requires :contact_number
		optional :file
		optional :file_type
	end
	post :resume, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		@user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name,
			:last_name, :gender,  :date_of_birth, :nationality, :address, :city, :zipcode, :country_id,
			:contact_number, :file_type )
		@user.file = params[:file] if params[:file]
		error! @user.errors.full_messages.join(', '), 422 unless @user.save
	end
	desc 'Update User Resume'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :title
		optional :first_name
		optional :middle_name
		optional :last_name
		optional :gender  
		optional :date_of_birth 
		optional :nationality 
		optional :address 
		optional :city
		optional :zipcode
		requires :country_id
		optional :contact_number
		optional :file
		optional :file_type
	end
	post :update_resume, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error!({error: 'User not found', status: 'Fail'}, 200) unless @user
		@user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name,
			:last_name, :gender,  :date_of_birth, :nationality, :address, :city, :zipcode, :country_id,
			:contact_number, :file_type )
		if params[:file_type].blank?
			@user.file = "https://selfie-cv-development.herokuapp.com/assets/default-a2ea80482f7fa6ea448186807f670258d6530fd183154b16d49a78530adbce67.png"
		else
			@user.file = params[:file] if params[:file]
		end
		@user.update_cv_count += 1
		@user.save
		error! @user.errors.full_messages.join(', '), 422 unless @user.save
	end
	desc 'Get User Resume'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_user_resume, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
	end
	desc 'User Education'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :course_id
		optional :specialization_id
		optional :year
		optional :school
		optional :skill
	end
	post :education, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_education = UserEducation.new user_id: @find_user.id
		if (params[:course_id] || params[:specialization_id] || params[:year] || params[:school] || params[:skill] )
			@user_education.attributes = clean_params(params).permit(:course_id, :specialization_id,  :year, :school, :skill)
			error! @user_education.errors.full_messages.join(', '), 422 unless @user_education.save
		end
	end
	desc 'Update User Education'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :education_id
		optional :course_id
		optional :specialization_id
		optional :year
		optional :school
		optional :skill
	end
	post :update_education, jbuilder: 'ios' do
		@user_education = UserEducation.find params[:education_id]
		error! 'User Education not found',422 unless @user_education
		@user_education.attributes = clean_params(params).permit(:course_id, :specialization_id, :year,
			:school, :skill)
		error! @user_education.errors.full_messages.join(', '), 422 unless @user_education.save
	end
	desc 'Get Users Education Detail'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_educations, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_educations = @find_user.user_educations
	end
	desc 'Delete Education'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :education_id
	end
	post :delete_education do
		@education = UserEducation.find params[:education_id]
		error! 'User Education not found',422 unless @education
		@education.destroy
		status 200
	end
	desc 'User Experience'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :name
		requires :exp_type
		optional :start_from
		optional :working_till
		optional :designation
		optional :description
		optional :current_company
		optional :file
		optional :file_type
	end
	post :experience, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_experience = UserExperience.new user_id: @find_user.id
		@user_experience.attributes = clean_params(params).permit(:name, :start_from,  :working_till, :designation, :description, :current_company, :exp_type, :file_type )
		@user_experience.file = params[:file] if params[:file]
		error! @user_experience.errors.full_messages.join(', '), 422 unless @user_experience.save
	end
	desc 'Update User Experience'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :experience_id
		optional :name
		optional :exp_type
		optional :start_from
		optional :working_till
		optional :designation
		optional :description
		optional :current_company
		optional :file
		optional :file_type
	end
	post :update_experience, jbuilder: 'ios' do
		@user_experience = UserExperience.find params[:experience_id]
		error! 'User Experience not found',422 unless @user_experience
		@user_experience.attributes = clean_params(params).permit(:name, :start_from, :working_till,
			:designation, :description, :current_company, :exp_type, :file_type )
		@user_experience.file = params[:file] if params[:file]
		error! @user_experience.errors.full_messages.join(', '), 422 unless @user_experience.save
	end
	desc 'Get Users Experience Detail'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_experiences, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_experiences = @find_user.user_experiences
	end
	desc 'Delete Experience'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :experience_id
	end
	post :delete_experience do
		@experience = UserExperience.find params[:experience_id]
		error! 'User Experience not found',422 unless @experience
		@experience.destroy
		status 200
	end
	desc 'User Preferred Work'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :ind_name
		optional :functional_name
		optional :preferred_designation
		optional :preferred_location
		optional :current_salary
		optional :expected_salary
		optional :time_type
	end
	post :preferred_work, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:ind_name] || params[:functional_name] || params[:preferred_designation] || params[:preferred_location] || params[:current_salary] || params[:expected_salary] || params[:time_type] )
			@user_preferred_work = UserPreferredWork.new user_id: @find_user.id
			@user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
			error! @user_preferred_work.errors.full_messages.join(', '), 422 unless @user_preferred_work.save
		end
	end
	desc 'Update User Preferred Work'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :preferred_work_id
		optional :ind_name
		optional :functional_name
		optional :preferred_designation
		optional :preferred_location
		optional :current_salary
		optional :expected_salary
		optional :time_type
	end
	post :update_preferred_work, jbuilder: 'ios' do
		@user_preferred_work = UserPreferredWork.find params[:preferred_work_id]
		error! 'User not found',422 unless @user_preferred_work
		@user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
		error! @user_preferred_work.errors.full_messages.join(', '), 422 unless @user_preferred_work.save
	end
	desc 'Get Users Preferred Work'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_preferred_works, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_preferred_works = @find_user.user_preferred_works
	end
	desc 'Delete Preffered Work'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :preffered_work_id
	end
	post :delete_preffered_work do
		@preffered_work = UserPreferredWork.find params[:preffered_work_id]
		error! 'User Preffered Work not found',422 unless @preffered_work
		@preffered_work.destroy
		status 200
	end
	desc 'User Award'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :award_type
		optional :name        
		optional :description        
		optional :file
		optional :file_type
	end
	post :award, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:award_type] || params[:name] || params[:descrption] )
			@award = UserAward.new user_id: @find_user.id
			@award.attributes = clean_params(params).permit(:name, :description, :file_type )
			@award.award_type = params[:award_type] if params[:award_type]
			@award.file = params[:file] if params[:file]
			error! @award.errors.full_messages.join(', '), 422 unless @award.save
		end
	end
	desc 'Update User Award'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :award_id
		optional :award_type
		optional :name        
		optional :description        
		optional :file
		optional :file_type
	end
	post :update_award, jbuilder: 'ios' do
		@award = UserAward.find params[:award_id]
		error! 'User not found',422 unless @award
		@award.attributes = clean_params(params).permit(:name, :description, :file_type )
		@award.file = params[:file] if params[:file]
		error! @award.errors.full_messages.join(', '), 422 unless @award.save
	end
	desc 'Get Users Award'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_award, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_awards = @find_user.user_awards
	end
	desc 'Delete Award'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :award_id
	end
	post :delete_award do
		@award = UserAward.find params[:award_id]
		error! 'User Award not found',422 unless @award
		@award.destroy
		status 200
	end
	desc 'User Certificate'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :name
		optional :year
		optional :certificate_type        
		optional :file
		optional :file_type
	end
	post :certificate, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:name] || params[:year] || params[:certificate_type] )
			@certificate = UserCertificate.new user_id: @find_user.id
			@certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type, :file_type )
			@certificate.file = params[:file] if params[:file]
			error! @certificate.errors.full_messages.join(', '), 422 unless @certificate.save
		end
	end
	desc 'Update User Certificate'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :certificate_id
		optional :name
		optional :year
		optional :certificate_type        
		optional :file
		optional :file_type
	end
	post :update_certificate, jbuilder: 'ios' do
		@certificate = UserCertificate.find params[:certificate_id]
		error! 'User Certificate not found',422 unless @certificate
		@certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type, :file_type )
		@certificate.file = params[:file] if params[:file]
		error! @certificate.errors.full_messages.join(', '), 422 unless @certificate.save
	end
	desc 'Get Users Certificate Detail'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_certificates, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_certificates = @find_user.user_certificates
	end
	desc 'Delete Certificate'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :certificate_id
	end
	post :delete_certificate do
		@certificate = UserCertificate.find params[:certificate_id]
		error! 'User Certificate not found',422 unless @certificate
		@certificate.destroy
		status 200
	end
	desc 'User Curriculars'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :curricular_type
		requires :title
		optional :team_type        
		optional :location
		optional :date
		optional :file
		optional :file_type
	end
	post :curriculars, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:curricular_type] || params[:title] || params[:team_type] || params[:location] || params[:date] )
			@curricular = UserCurricular.new user_id: @find_user.id
			@curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date, :file_type )
			@curricular.file = params[:file] if params[:file]
			error! @curricular.errors.full_messages.join(', '), 422 unless @curricular.save 
		end         
	end
	desc 'Update User Curriculars'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :curricular_id
		optional :curricular_type
		optional :title
		optional :team_type        
		optional :location
		optional :date
		optional :file
		optional :file_type
	end
	post :update_curricular, jbuilder: 'ios' do
		@curricular = UserCurricular.find params[:curricular_id]
		error! 'User Curricular not found',422 unless @curricular
		@curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date, :file_type )
		@curricular.file = params[:file] if params[:file]
		error! @curricular.errors.full_messages.join(', '), 422 unless @curricular.save
	end
	desc 'Get Users Curriculars Detail'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_curriculars, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_curriculars = @find_user.user_curriculars
	end
	desc 'Delete Curricular'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :curricular_id
	end
	post :delete_curricular do
		@curricular = UserCurricular.find params[:curricular_id]
		error! 'User Curricular not found',422 unless @curricular
		@curricular.destroy
		status 200
	end
	desc 'User Future Goal'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :goal_type
		optional :title
		optional :term_type        
		optional :file
		optional :file_type
	end
	post :future_goal, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:goal_type] || params[:title] || params[:term_type] )
			@future_goal = UserFutureGoal.new user_id: @find_user.id, goal_type: params[:goal_type], title: params[:title],term_type: params[:term_type]
			@future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type, :file_type )
			@future_goal.file = params[:file] if params[:file]
			error! @future_goal.errors.full_messages.join(', '), 422 unless @future_goal.save
		end          
	end
	desc 'Update User Future Goal'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :future_goal_id
		optional :goal_type
		optional :title
		optional :term_type        
		optional :file
		optional :file_type
	end
	post :update_future_goal, jbuilder: 'ios' do
		@future_goal = UserFutureGoal.find params[:future_goal_id]
		error! 'User Future Goal not found',422 unless @future_goal
		@future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type, :file_type )
		@future_goal.file = params[:file] if params[:file]
		error! @future_goal.errors.full_messages.join(', '), 422 unless @future_goal.save
	end
	desc 'Get Users Future Goals Detail'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_future_goals, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_future_goals = @find_user.user_future_goals
	end
	desc 'Delete Future Goal'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :future_goal_id
	end
	post :delete_future_goal do
		@future_goal = UserFutureGoal.find params[:future_goal_id]
		error! 'User Future Goal not found',422 unless @future_goal
		@future_goal.destroy
		status 200
	end
	desc 'User Working Environment'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :env_type
		optional :title
		optional :file
		optional :text_field
		optional :file_type
	end
	post :working_environment, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:env_type] || params[:title] )
			@environment = UserEnvironment.new user_id: @find_user.id
			@environment.attributes = clean_params(params).permit(:env_type, :title, :file_type, :text_field)
			if (params[:file_type] == 'text')
				@environment.text_field = params[:text_field] if params[:text_field]
			else
				@environment.file = params[:file] if params[:file]
			end
			error! @environment.errors.full_messages.join(', '), 422 unless @environment.save
		end          
	end
	desc 'Update User Working Environment'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :environment_id
		optional :env_type
		optional :title
		optional :file
		optional :text_field
		optional :file_type
	end
	post :update_working_environment, jbuilder: 'ios' do
		@environment = UserEnvironment.find params[:environment_id]
		error! 'User Environment not found',422 unless @environment
		@environment.attributes = clean_params(params).permit(:env_type, :title, :file_type, :text_field)
		if (params[:file_type] == 'text')
			@environment.text_field = params[:text_field] if params[:text_field]
		else
			@environment.file = params[:file] if params[:file]
		end
		error! @environment.errors.full_messages.join(', '), 422 unless @environment.save
	end
	desc 'Get Users Working Environments Detail'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_working_environments, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_working_environments = @find_user.user_environments
	end
	desc 'Delete Work Environment'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :work_env_id
	end
	post :delete_work_env do
		@work_env = UserEnvironment.find params[:work_env_id]
		error! 'User Work Environment not found',422 unless @work_env
		@work_env.destroy
		status 200
	end
	desc 'User References'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :title
		optional :ref_type
		optional :from        
		optional :email
		optional :contact
		optional :date
		optional :location
		optional :file
		optional :text_field
		optional :file_type
	end
	post :references, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@reference = UserReference.new user_id: @find_user.id
		if (params[:title] || params[:ref_type] || params[:from] || params[:email] || params[:contact] || params[:date] || params[:location] )
			@reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location, :file_type, :text_field)
			if (params[:file_type] == 'text')
				@reference.text_field = params[:text_field] if params[:text_field]
			else
				@reference.file = params[:file] if params[:file]
			end
			error! @reference.errors.full_messages.join(', '), 422 unless @reference.save
		end          
	end
	desc 'Update User References'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :reference_id
		optional :title
		optional :ref_type
		optional :from        
		optional :email
		optional :contact
		optional :date
		optional :location
		optional :file
		optional :text_field
		optional :file_type
	end
	post :update_references, jbuilder: 'ios' do
		@reference = UserReference.find params[:reference_id]
		error! 'User not found',422 unless @reference
		@reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location, :file_type, :text_field)
		if (params[:file_type] == 'text')
			@reference.text_field = params[:text_field] if params[:text_field]
		else
			@reference.file = params[:file] if params[:file]
		end
		error! @reference.errors.full_messages.join(', '), 422 unless @reference.save
	end
	desc 'Get Users References Detail'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_references, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_references = @find_user.user_references
	end
	desc 'Delete reference'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :reference_id
	end
	post :delete_reference do
		@reference = UserReference.find params[:reference_id]
		error! 'User Reference not found',422 unless @reference
		@reference.destroy
		status 200	
	end
end
#--------------------------------member profile end----------------------------------#
#--------------------------------company start----------------------------------#
resources :company do 
	before { authenticate! }
	desc 'Company Information'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :company_name
		optional :company_establish_from
		requires :industry_id        
		requires :company_functional_area
		requires :company_address
		requires :company_zipcode
		requires :company_city
		requires :company_contact
		optional :company_skype_id
		requires :company_id
		requires :country_id
	end
	post :company_info, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		if @user.role == 'Company'
			@user.attributes = clean_params(params).permit(:company_name, :company_establish_from, :industry_id, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id, :company_id, :country_id)
			error! @user.errors.full_messages.join(', '), 422 unless @user.save
		else
			error! "Record not found.", 422
		end
	end
	desc 'Corporate Identity'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :company_logo
		requires :company_logo_type
		optional :company_profile
		optional :company_profile_type
		optional :company_brochure        
		optional :company_brochure_type  
		optional :company_website
		optional :company_facebook_link
	end
	post :corporate_identity, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		if @user.role == 'Company'
			@user.attributes = clean_params(params).permit(:company_website, :company_facebook_link, :company_logo_type ,:company_profile_type, :company_brochure_type)
			@user.company_logo = params[:company_logo] if params[:company_logo]
			@user.company_profile = params[:company_profile] if params[:company_profile]
			@user.company_brochure = params[:company_brochure] if params[:company_brochure]
			error! @user.errors.full_messages.join(', '), 422 unless @user.save
		else
			error! "Record not found.", 422
		end
	end
	desc 'Company Evalution Information'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :company_turnover
		requires :company_no_of_emp
		optional :company_growth_ratio        
		optional :company_new_ventures
	end
	post :evalution_information, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		if @user.role == 'Company'
			@user.attributes = clean_params(params).permit(:company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures )
			error! @user.errors.full_messages.join(', '), 422 unless @user.save
		else
			error! "Record not found.", 422
		end
	end
	desc 'Get Company Evalution Information'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_company_information, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found', 422 unless @user
	end
	desc 'Company Future Goal'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :company_future_turnover
		optional :company_future_new_venture_location
		optional :company_future_outlet
	end
	post :future_goal, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		if @user.role == 'Company'
			@user.attributes = clean_params(params).permit(:company_future_turnover, :company_future_new_venture_location, :company_future_outlet)
			error! @user.errors.full_messages.join(', '), 422 unless @user.save
		else
			error! "Record not found.", 422
		end
	end
	desc 'Edit Company Info'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :company_name
		optional :company_establish_from
		optional :industry_id        
		optional :company_functional_area
		optional :company_address
		optional :company_zipcode
		optional :company_city
		optional :country_id
		optional :company_contact
		optional :company_skype_id
		optional :company_id
		optional :company_logo
		optional :company_logo_type
		optional :company_profile
		optional :company_profile_type
		optional :company_brochure        
		optional :company_brochure_type        
		optional :company_website
		optional :company_facebook_link
		optional :company_turnover
		optional :company_no_of_emp
		optional :company_growth_ratio        
		optional :company_new_ventures
		optional :company_future_turnover
		optional :company_future_new_venture_location
		optional :company_future_outlet
	end
	post :edit_company, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		@user.attributes = clean_params(params).permit(:company_name, :company_establish_from, :industry_id, :company_functional_area, :company_address, :company_zipcode, :company_city, :country_id, :company_contact, :company_skype_id, :company_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet, :company_logo_type, :company_profile_type, :company_brochure_type)
		@user.company_logo = params[:company_logo] if params[:company_logo]
		@user.company_profile = params[:company_profile] if params[:company_profile]
		@user.company_brochure = params[:company_brochure] if params[:company_brochure]
		error! @user.errors.full_messages.join(', '), 422 unless @user.save
	end
	desc 'Company Galery'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :files, type: Array, default: []
	end
	post :galery, jbuilder: 'ios_galery' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		params[:files].each do |file|
			@galery = CompanyGalery.new user_id: params[:user_id]
			@galery.file = file
			error! @galery.errors.full_messages.join(', '), 422 unless @galery.save
			@galeries = @find_user.company_galeries
		end      
	end
	desc 'Company Galery Listing'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :galery_listing, jbuilder: 'android_galery' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@galeries = @find_user.company_galeries
	end
	desc 'Company Galery  Delete Multiple Photos'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :delete_ids, type: Array, default: []
	end
	post :delete_photos, jbuilder: 'android_galery' do
		params[:delete_ids].each do |delete_id|
			@galery = CompanyGalery.find delete_id
			error! 'Something went wrong.Please try again.!',422 unless @galery.destroy
		end   
		status 200  
	end
end
#--------------------------------company end----------------------------------#
#--------------------------------data start-----------------------------------#
resources :data do 
	desc 'Dropdown Data'
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :all_data, jbuilder: 'ios' do
		@courses = Course.all
		@specializations = Specialization.all
		@companies = Company.all
		@industries = Industry.all
		@stock_countries = StockCountry.all
	end
	desc 'Update Image'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :profile_pic
		optional :back_profile
		optional :profile_pic_type
    	optional :back_profile_type
	end
	post :update_image, jbuilder: 'ios' do
		authenticate!
		@update_image = User.find params[:user_id]
		error! 'User not found',422 unless @update_image
		@update_image.attributes = clean_params(params).permit(:profile_pic_type, :back_profile_type)
		@update_image.profile_pic = params[:profile_pic] if params[:profile_pic]
		@update_image.back_profile = params[:back_profile] if params[:back_profile]
		error! @update_image.errors.full_messages.join(', '), 422 unless @update_image.save
	end
	desc 'Video For Appflow'
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :video, jbuilder: 'ios' do
		authenticate!
		@video = VideoUpload.where(role: VideoUpload::ROLES[params[:role]]).first
	end
end
#--------------------------------data end----------------------------------#
#--------------------------------student start----------------------------------#
resources :student do 
	before { authenticate! }
	desc 'Student Basic Info'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :first_name
		optional :last_name
		optional :gender  
		optional :date_of_birth 
		optional :nationality 
		optional :address 
		optional :city
		optional :zipcode
		requires :country_id
		optional :contact_number
	end
	post :basic_info, jbuilder: 'ios' do
		@basic_info = User.find params[:user_id]
		error!({error: 'User not found', status: 'Fail'}, 200) unless @basic_info
		@basic_info.attributes = clean_params(params).permit(:first_name,  :last_name, :gender,  :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number )
		error! @basic_info.errors.full_messages.join(', '), 422 unless @basic_info.save
	end
	desc 'Update Student Basic Info'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :first_name
		optional :last_name
		optional :gender  
		optional :date_of_birth 
		optional :nationality 
		optional :address 
		optional :city
		optional :zipcode
		requires :country_id
		optional :contact_number
		optional :file
		optional :file_type
	end
	post :update_basic_info, jbuilder: 'ios' do
		@basic_info = User.find params[:user_id]
		error! 'User not found', 422 unless @basic_info
		@basic_info.attributes = clean_params(params).permit(:first_name, :last_name, :gender,
			:date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type)
		error! @basic_info.errors.full_messages.join(', '), 422 unless @basic_info.save
	end
	desc 'Get Basic Info'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :get_basic_info, jbuilder: 'ios' do
		@basic_info = User.find params[:user_id]
		error! 'User not found', 422 unless @basic_info
	end
	desc 'Student Education'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :standard
		optional :school
		optional :year
	end
	post :student_education, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:standard] || params[:school] || params[:year] )
			@student_education = StudentEducation.new user_id: @find_user.id
			@student_education.attributes = clean_params(params).permit(:standard, :school, :year)
			error! @student_education.errors.full_messages.join(', '), 422 unless @student_education.save
		end          
	end
	desc 'Update Student Education'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :education_id
		optional :standard
		optional :school
		optional :year
	end
	post :update_student_education, jbuilder: 'ios' do
		@student_education = StudentEducation.find params[:education_id]
		error! 'User Environment not found',422 unless @student_education
		@student_education.attributes = clean_params(params).permit(:standard, :school, :year)
		@student_education.file = params[:file] if params[:file]
		error! @student_education.errors.full_messages.join(', '), 422 unless @student_education.save
	end
	desc 'Delete Student Education'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :education_id
	end
	post :delete_student_education do
		@student_education = StudentEducation.find params[:education_id]
		error! 'Student Education not found',422 unless @student_education
		@student_education.destroy
		status 200
	end
	desc 'Student Marksheet'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :school_name
		optional :standard
		optional :grade
		optional :year
		optional :file
		optional :file_type
	end
	post :student_marksheet, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:school_name] || params[:standard] || params[:grade] || params[:year] )
			@student_marksheet = UserMarksheet.new user_id: @find_user.id
			@student_marksheet.attributes = clean_params(params).permit(:school_name, :standard, :grade, :year, :file_type)
			@student_marksheet.file = params[:file] if params[:file]
			error! @student_marksheet.errors.full_messages.join(', '),422 unless @student_marksheet.save
		end          
	end
	desc 'Update Student Education'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :marksheet_id
		optional :school_name
		optional :standard
		optional :grade
		optional :year
		optional :file
		optional :file_type
	end
	post :update_student_marksheet, jbuilder: 'ios' do
		@student_marksheet = UserMarksheet.find params[:marksheet_id]
		error! 'Student marksheet not found',422 unless @student_marksheet
		@student_marksheet.attributes = clean_params(params).permit(:school_name, :standard, :grade, :year, :file_type)
		@student_marksheet.file = params[:file] if params[:file]
		error! @student_marksheet.errors.full_messages.join(', '),422 unless @student_marksheet.save
	end
	desc 'Delete Student Marksheet'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :marksheet_id
	end
	post :delete_student_marksheet do
		@student_marksheet = UserMarksheet.find params[:marksheet_id]
		error! 'Student Marksheet not found',422 unless @student_marksheet
		@student_marksheet.destroy
		status 200
	end
	desc 'Student Project'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :title
		optional :description
		optional :file
		optional :file_type
	end
	post :student_project, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:title] || params[:description] )
			@student_project = UserProject.new user_id: @find_user.id
			@student_project.attributes = clean_params(params).permit(:title, :description, :file_type)
			@student_project.file = params[:file] if params[:file]
			error! @student_project.errors.full_messages.join(', '),422 unless @student_project.save
		end          
	end
	desc 'Update Student Project'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :project_id
		optional :title
		optional :description
		optional :file
		optional :file_type
	end
	post :update_student_project, jbuilder: 'ios' do
		@student_project = UserProject.find params[:project_id]
		error! 'Student project not found',422 unless @student_project
		@student_project.attributes = clean_params(params).permit(:title, :description, :file_type)
		@student_project.file = params[:file] if params[:file]
		error! @student_project.errors.full_messages.join(', '),422 unless @student_project.save
	end
	desc 'Delete Student Project'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :project_id
	end
	post :delete_student_project do
		@student_project = UserProject.find params[:project_id]
		error! 'Student Project not found',422 unless @student_project
		@student_project.destroy
		status 200
	end
end
#--------------------------------student end----------------------------------#
#--------------------------------faculty start----------------------------------#
resources :faculty do 
	before { authenticate! }
	desc 'Faculty Resume'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :first_name
		optional :middle_name
		optional :last_name
		optional :gender  
		optional :date_of_birth 
		optional :nationality 
		optional :address 
		optional :city
		optional :zipcode
		requires :country_id
		optional :contact_number
		optional :file
		optional :file_type
	end
	post :basic_info, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		@user.attributes = clean_params(params).permit(:first_name,  :middle_name, :last_name, :gender,
			:date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type)
		@user.file = params[:file] if params[:file]
		error! @user.errors.full_messages.join(', '),422 unless @user.save
	end
	desc 'Edit Faculty Resume'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :first_name
		optional :middle_name
		optional :last_name
		optional :gender  
		optional :date_of_birth 
		optional :nationality 
		optional :address 
		optional :city
		optional :country_id
		optional :zipcode
		optional :contact_number
		optional :file
		optional :file_type
	end
	post :edit_basic_info, jbuilder: 'ios' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		@user.attributes = clean_params(params).permit(:first_name,  :middle_name, :last_name, :gender,
			:date_of_birth, :nationality, :address, :city, :country_id, :zipcode,  :contact_number, :file_type)
		@user.file = params[:file] if params[:file]
		error! @user.errors.full_messages.join(', '),422 unless @user.save
	end
	desc 'Faculty Affiliation'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		optional :university
		requires :collage_name
		optional :subject
		optional :designation
		optional :join_from
		optional :join_till
		optional :file
		optional :file_type
	end
	post :faculty_affiliation, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:collage_name] || params[:subject] || params[:designation] || params[:join_from] || params[:join_till] || params[:file_type])
			@faculty_affiliation = FacultyAffiliation.new user_id: @find_user.id
			@faculty_affiliation.attributes = clean_params(params).permit(:university, :collage_name, :subject, :designation, :join_from, :join_till, :file_type)
			@faculty_affiliation.file = params[:file] if params[:file]
			error! @faculty_affiliation.errors.full_messages.join(', '),422 unless @faculty_affiliation.save
		end          
	end
	desc 'Update Faculty Affiliation'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :affiliation_id
		optional :university
		optional :collage_name
		optional :subject
		optional :designation
		optional :join_from
		optional :join_till
		optional :file
		optional :file_type
	end
	post :update_faculty_affiliation, jbuilder: 'ios' do
		@faculty_affiliation = FacultyAffiliation.find params[:affiliation_id]
		error! 'Faculty affiliation not found',422 unless @faculty_affiliation
		@faculty_affiliation.attributes = clean_params(params).permit(:university, :collage_name, :subject, :designation, :join_from, :join_till, :file_type)
		@faculty_affiliation.file = params[:file] if params[:file]
		error! @faculty_affiliation.errors.full_messages.join(', '),422 unless @faculty_affiliation.save
	end
	desc 'Delete Faculty Affiliation'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :affiliation_id
	end
	post :delete_faculty_affiliation do
		@faculty_affiliation = FacultyAffiliation.find params[:affiliation_id]
		error! 'Faculty Affiliation not found',422 unless @faculty_affiliation
		@faculty_affiliation.destroy
		status 200
	end
	desc 'Faculty Workshop'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :title
		requires :description
		optional :file
		optional :file_type
	end
	post :faculty_workshop, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@faculty_workshop = FacultyWorkshop.new user_id: @find_user.id
		@faculty_workshop.attributes = clean_params(params).permit(:title, :description, :file_type)
		@faculty_workshop.file = params[:file] if params[:file]
		error!({error: @faculty_workshop.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_workshop.save
	end
	desc 'Update Faculty Workshop'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :workshop_id
		optional :title
		optional :description
		optional :file
		optional :file_type
	end
	post :update_faculty_workshop, jbuilder: 'ios' do
		@faculty_workshop = FacultyWorkshop.find params[:workshop_id]
		error! 'Faculty workshop not found',422 unless @faculty_workshop
		@faculty_workshop.attributes = clean_params(params).permit(:title, :description, :file_type)
		@faculty_workshop.file = params[:file] if params[:file]
		error! @faculty_workshop.errors.full_messages.join(', '),422 unless @faculty_workshop.save
	end
	desc 'Delete Faculty Workshop'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :workshop_id
	end
	post :delete_faculty_workshop do
		@faculty_workshop = FacultyWorkshop.find params[:workshop_id]
		error! 'Faculty Workshop not found',422 unless @faculty_workshop
		@faculty_workshop.destroy
		status 200
	end
	desc 'Faculty Publication'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :title
		optional :description
		optional :file
		optional :file_type
	end
	post :faculty_publication, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:title] || params[:description] )
			@faculty_publication = FacultyPublication.new user_id: @find_user.id
			@faculty_publication.attributes = clean_params(params).permit(:title, :description, :file_type)
			@faculty_publication.file = params[:file] if params[:file]
			error! @faculty_publication.errors.full_messages.join(', '),422 unless @faculty_publication.save
		end          
	end
	desc 'Update Faculty Publication'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :publication_id
		optional :title
		optional :description
		optional :file
		optional :file_type
	end
	post :update_faculty_publication, jbuilder: 'ios' do
		@faculty_publication = FacultyPublication.find params[:publication_id]
		error! 'Student publication not found',422 unless @faculty_publication
		@faculty_publication.attributes = clean_params(params).permit(:title, :description, :file_type)
		@faculty_publication.file = params[:file] if params[:file]
		error! @faculty_publication.errors.full_messages.join(', '),422 unless @faculty_publication.save
	end
	desc 'Delete Faculty Publication'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :publication_id
	end
	post :delete_faculty_publication do
		@faculty_publication = FacultyPublication.find params[:publication_id]
		error! 'Faculty Publication not found',422 unless @faculty_publication
		@faculty_publication.destroy
		status 200
	end
	desc 'Faculty Research'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :title
		optional :description
		optional :file
		optional :file_type
	end
	post :faculty_research, jbuilder: 'ios' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		if (params[:title] || params[:description] )
			@faculty_research = FacultyResearch.new user_id: @find_user.id
			@faculty_research.attributes = clean_params(params).permit(:title, :description, :file_type)
			@faculty_research.file = params[:file] if params[:file]
			error! @faculty_research.errors.full_messages.join(', '),422 unless @faculty_research.save
		end          
	end
	desc 'Update Faculty Reaserch'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :research_id
		optional :title
		optional :description
		optional :file
		optional :file_type
	end
	post :update_faculty_research, jbuilder: 'ios' do
		@faculty_research = FacultyResearch.find params[:research_id]
		error! 'Student research not found',422 unless @faculty_research
		@faculty_research.attributes = clean_params(params).permit(:title, :description, :file_type)
		@faculty_research.file = params[:file] if params[:file]
		error! @faculty_research.errors.full_messages.join(', '),422 unless @faculty_research.save
	end
	desc 'Delete Faculty Research'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :research_id
	end
	post :delete_faculty_research do
		@faculty_research = FacultyResearch.find params[:research_id]
		error! 'Faculty Research not found',422 unless @faculty_research
		@faculty_research.destroy
		status 200
	end
end
#--------------------------------faculty end----------------------------------#
#--------------------------------group start----------------------------------#
resources :group do 
	before { authenticate! }
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :name
		optional :group_pic
	end
	post :create, jbuilder: 'ios_group' do
		@group = Group.new clean_params(params).permit(:name)
		@group.code = Random.rand(500000..900000)
		@group.group_pic = params[:group_pic] if params[:group_pic]
		error! @group.errors.full_messages.join(', '), 422 unless @group.save
		@group_user = GroupUser.new user_id: current_user.id, group_id: @group.id, admin: true , status: 'joined' 
		error! @group_user.errors.full_messages.join(', '), 422 unless @group_user.save
		@chat = Chat.new
		@chat.sender_id = current_user.id
		@chat.group_id = @group.id
		@chat.activity = "true"
		@chat.quick_msg = "created"
		@chat.save
	end
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :listing, jbuilder: 'ios_group' do
		@groups = current_user.all_groups(current_user)
	end
	desc 'Information of Group'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_id
	end
	post :info, jbuilder: 'ios_group' do
		@group = Group.find(params[:group_id])
		error! 'Group not found',422 unless @group
	end
	desc 'Update Group'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_id
		optional :name
		optional :group_pic
	end
	post :update, jbuilder: 'android_group' do
		@group = Group.find params[:group_id]
		error! 'Group not found',422 unless @group
		@group.attributes = clean_params(params).permit(:name)
		@group.group_pic = params[:group_pic] if params[:group_pic]
		error! @group.errors.full_messages.join(', '), 422 unless @group.save
	end
	desc 'Delete Group'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_id
		optional :user_id
	end
	post :delete do
		@group = Group.find params[:group_id]  
		error! 'Group not found',422 unless @group
		if params[:user_id]   
			@user = User.find params[:user_id] 
			error! 'User not found',422 unless @user  
			@group_user = GroupUser.find_by_user_id params[:user_id]
			error! 'Group User not found',422 unless @group_user
			unless @group.deleted_from.include? @user.id
				@group.deleted_from << @user.id
				@group.update_column :deleted_from, @group.deleted_from
			end       
			@group_user.status = 'deleted'
			@group_user.save 
			@chat = Chat.new
			@chat.sender_id = current_user.id
			@chat.group_id = params[:group_id]
			@chat.activity = "true"
			@chat.quick_msg = "removed #{@user.username}"
			@chat.save
		else
			if current_user.role == 'Faculty'
				@group.destroy
			else
				unless @group.deleted_from.include? current_user.id
					@group.deleted_from << current_user.id
					@group.update_column :deleted_from, @group.deleted_from
				end
			end
		end
		status 200
	end
	desc 'Registered Students'
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :registered_students, jbuilder: 'ios' do
		@students = User.where(role: 1).all
	end
	desc 'Email invitation'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_id
		requires :email_ids, type: Array, default: []
	end
	get :email_invite do
		@group = Group.find params[:group_id]
		error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
		params[:email_ids].each do |email|
			@group_invitee = GroupInvitee.new group_id: params[:group_id], email: email
			error! @group_invitee.errors.full_messages.join(', '),422 unless @group_invitee.save
			UserMailer.send_group_code(@group,email).deliver_now
		end
		{}
	end
	desc 'Join Group'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :code
	end
	post :join, jbuilder: 'android_group' do
		@group = Group.find_by_code params[:code]
		error! 'Group not found or wrong code',422 unless @group
		@group_invitee = @group.group_invitees.where(email: current_user.email).first
		error! "You are unauthorized for this group.", 422 unless @group_invitee
		@group_user = @group.users.where(user_id: current_user.id).first
		error! "You are already in this group.", 422 if @group_user
		if @group_invitee.present?
			@group_user = GroupUser.new user_id: current_user.id, group_id: @group.id , admin: false , status: 'joined'
			error! @group_user.errors.full_messages.join(', '),422 unless @group_user.save      
			@chat = Chat.new
			@chat.sender_id = current_user.id
			@chat.group_id = @group.id
			@chat.activity = "true"
			@chat.quick_msg = "joined"
			@chat.save
# @group.accepted_users.each do |group_user|
#     #Device.notify group_user.user.active_devices, { msg: "#{current_user.username} has join to group #{@group}.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
# end
end      
end
desc 'Leave Group'
params do
	requires :token, type: String, regexp: UUID_REGEX
	requires :group_id
end
post :leave, jbuilder: 'ios_group' do
	@group = Group.find params[:group_id]
	error! 'Group not found',422 unless @group
	@group_user = @group.users.where(user_id: current_user.id).first
	@group_user.status = "leaved"          
	@group_user.deleted_at = Time.now
	@group_user.save
	@chat = Chat.new
	@chat.sender_id = current_user.id
	@chat.group_id = @group.id
	@chat.activity = "true"
	@chat.quick_msg = "left"
	@chat.save
	@group.accepted_users.each do |group_user|
#Device.notify group_user.user.active_devices, { msg: "#{current_user.username} has left group #{@group}.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
end
end
desc 'Quick Message'
params do
	requires :token, type: String, regexp: UUID_REGEX
	requires :role
end
post :quick_message, jbuilder: 'ios_message' do
	@messages = QuickMessage.where(role: QuickMessage::ROLES[params[:role]])
end
desc 'Search Group Of Current User'
params do
	requires :token, type: String, regexp: UUID_REGEX
	requires :q
end
post :search , jbuilder: 'ios_group' do
	authenticate!
	@groups =  current_user.all_groups.search(params[:q])
end
end
#--------------------------------group end----------------------------------#
#--------------------------------message start----------------------------------#
resources :messages do
	before { authenticate! }
	desc 'create Chat'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_id
		optional :quick_msg
		optional :file
		optional :file_type
		optional :text_value
	end
	post :create, jbuilder: 'ios_message' do
		@chat = Chat.new group_id: params[:group_id], sender_id: current_user.id
		@chat.file_type = params[:file_type] if params[:file_type]
		if params[:quick_msg_id]
			@msg = QuickMessage.find params[:quick_msg_id]
			error! 'Quick Message not found',422 unless @msg
			@chat.quick_msg = @msg.text
		else
			@chat.quick_msg = params[:text_value] if params[:text_value]
		end
		error! @chat.errors.full_messages.join(', '),422 unless @chat.save 
	end
	desc 'read Message'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_id
	end
	post :read , jbuilder: 'ios_message' do
		@group = Group.find params[:group_id]
		error! 'Group not found',422 unless @group
		@group.chats.each do |chat|       
			unless chat.user_ids.include? current_user.id
				chat.user_ids << current_user.id
				chat.update_column :user_ids, chat.user_ids
			end
		end
		status 200
	end
	desc 'Listing of Chat'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_id
	end
	post :listing, jbuilder: 'ios_message' do
		@group = Group.find params[:group_id]
		error! 'Group not found',422 unless @group
		@chats = @group.chats
		error! @chat.errors.full_messages.join(', '),422 unless @chats  
	end
	desc 'Create schedule'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :name
		requires :date, type: Array, default: []
		requires :my_time, type: Array, default: []
		requires :description, type: Array, default: []
		optional :info
		requires :group_id, type: Array, default: []
	end
	post :create_schedule, jbuilder: 'ios_message' do
		@chat_schedule = ChatSchedule.new
		@chat_schedule.name = params[:name] if params[:name]
		@chat_schedule.date = params[:date]
		@chat_schedule.my_time = params[:my_time]
		@chat_schedule.description = params[:description]
		@chat_schedule.info = params[:info] if params[:info]
		@chat_schedule.group_id = params[:group_id]
		error! @chat_schedule.errors.full_messages.join(', '),422 unless @chat_schedule.save
		params[:group_id].each do |q|
			@chat = Chat.new
			@chat.group_id = q
			@chat.sender_id = current_user.id
			@chat.chat_schedule_id = @chat_schedule.id
			@chat.save
		end
	end
	desc 'Create schedule'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :schedule_id
	end
	post :view_schedule, jbuilder: 'ios_message' do
		@chat_schedule = ChatSchedule.find params[:schedule_id]
		error! 'Schedule not found',422 unless @chat_schedule
	end
	desc 'Send File To Multiple Group'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :group_ids, type: Array, default: []
		optional :file
		optional :file_type
	end
	post :send_file_to_groups, jbuilder: 'android_message' do
		params[:group_ids].each do |group_id|
			@chat = Chat.new sender_id: current_user.id, group_id: group_id.to_i
			@chat.file_type = params[:file_type] if params[:file_type]
			@chat.file = params[:file] if params[:file]
			error! @chat.errors.full_messages.join(', '), 422 unless @chat.save
		end
	end
end
#--------------------------------message end----------------------------------#
#--------------------------------notification end----------------------------------#
resources :notifications do
	before { authenticate! }
	desc 'Like Profile'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :like_id
		requires :is_liked
	end
	post :like, jbuilder: 'ios_notification' do
		if params[:is_liked] == 'false'
			@user_like = UserLike.new user_id: current_user.id, like_id: params[:like_id]
			@user_like.is_liked = 'true'
			error! @user_like.errors.full_messages.join(', '),422 unless @user_like.save
#Device.notify User.find(params[:like_id]).active_devices, { msg: "#{current_user.username} liked your profile.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }    
else        
	error! 'You already like this profile!',422
end 
end
desc 'View Profile'
params do
	requires :token, type: String, regexp: UUID_REGEX
	requires :view_id
end
post :view, jbuilder: 'ios_notification' do
	@user_view = UserView.new user_id: current_user.id, view_id: params[:view_id]
	error! @user_view.errors.full_messages.join(', '),422 unless @user_view.save
##Device.notify User.find(params[:view_id]).active_devices, { msg: "#{current_user.username} viewed your profile.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }     
end
desc 'Share Profile'
params do
	requires :token, type: String, regexp: UUID_REGEX
	requires :share_id
	requires :share_type
end
post :share, jbuilder: 'ios_notification' do
	@user_share = UserShare.new user_id: current_user.id, share_id: params[:share_id], share_type: params[:share_type]
	error! @user_share.errors.full_messages.join(', '),422 unless @user_share.save
##Device.notify User.find(params[:share_id]).active_devices, { msg: "#{current_user.username} shared your profile on #{params[:share_type]}.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }     
end
desc 'Favourite Profile'
params do
  requires :token, type: String, regexp: UUID_REGEX
  requires :favourite_id
  requires :folder_name
  requires :is_favourited
end
post :favourite, jbuilder: 'ios_notification' do
  @a = UserFolder.joins(:folder).where("user_folders.user_id = ?", current_user.id).where('folders.name = ?', params[:folder_name].downcase).first
  if @a
    @folder = Folder.find @a.folder_id
    error! 'Folder not found', 422 unless @folder
  else
    @folder = Folder.new name: params[:folder_name].downcase, default_status: false
    error! @folder.errors.full_messages.join(', '), 422 unless @folder.save
    @user_folder = UserFolder.new user_id: current_user.id, folder_id: @folder.id
    error! @user.errors.full_messages.join(', '), 422 unless @user_folder.save
  end
  if params[:is_favourited] == 'false'
    @user_favourite = UserFavourite.new user_id: current_user.id, favourite_id: params[:favourite_id], folder_id: @folder.id
    @user_favourite.is_favourited = 'true'
    error! @user_favourite.errors.full_messages.join(', '), 422 unless @user_favourite.save     
  else        
    error! 'You already favourite this profile!', 422
  end
end
desc 'Rate Profile'
params do
	requires :token, type: String, regexp: UUID_REGEX
	requires :rate_id
	requires :rate_type
end
post :rate, jbuilder: 'ios_notification' do
	@user_rate = UserRate.new user_id: current_user.id, rate_id: params[:rate_id], rate_type: params[:rate_type]
	error! @user_rate.errors.full_messages.join(', '),422 unless @user_rate.save     
##Device.notify User.find(params[:rate_id]).active_devices, { msg: "#{current_user.username} rate your profile.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
end
desc  "LIST Of NOTIFICATION"
params  do
	requires :token, type: String, regexp: UUID_REGEX
end
post :list, jbuilder: "ios_notification"  do
	@notifications = Rpush::Apns::Notification.where(device_token: current_device.id).order(created_at: "desc").pluck
end
end
#--------------------------------notification end----------------------------------#
#--------------------------------top user start----------------------------------#
resources :top_user do
	before { authenticate! }
	desc 'Listing Top Users'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :role
	end
	post :listing, jbuilder: 'ios_top' do
		if (params[:role] == 'Company')
			@top_users  = User.joins(:user_meter).where(:users=> { role: 3 }).order("user_meters.total_per DESC").limit(3)
		elsif (params[:role] == 'Jobseeker')
			@top_users = User.joins(:user_meter).where(:users=> { role: 4 }).order("user_meters.total_per DESC").limit(3)
		end
	end
end
#--------------------------------top user end----------------------------------#
#--------------------------------whizquiz start----------------------------------#
resources :whizquiz do
	before { authenticate! }
	desc 'Send random 10 question to Users'
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :send_questions, jbuilder: 'ios_whiz_quiz' do
		@questions = Whizquiz.where(status: true).order("RANDOM()").limit(2)
	end
	desc 'Answer'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
		requires :question_ids, type: Array, default: []
		requires :review_types, type: Array, default: []
		requires :reviews, type: Array, default: []
		requires :text_fields, type: Array, default: []
	end
	post :answer_of_questions, jbuilder: 'android_whiz_quiz' do
		@user = User.find params[:user_id]
		error! 'User not found',422 unless @user
		params[:question_ids].count.times do |i|
			@user_whizquiz = UserWhizquiz.new user_id: params[:user_id], whizquiz_id: params[:question_ids][i] , review_type: params[:review_types][i] , review: params[:reviews][i], status: false
			if (params[:review_types][i] == 'text')
				@user_whizquiz.text_field = params[:text_fields][i] if params[:text_fields][i]
			else
				@user_whizquiz.review = params[:reviews][i] if params[:reviews][i]
			end
			error! @user_whizquiz.errors.full_messages.join(', '),422 unless @user_whizquiz.save
		end
	end
end
#--------------------------------whizquiz end----------------------------------#
#--------------------------------marketiq start----------------------------------#
resources :marketiq do
	before { authenticate! }
	desc 'Send random 10 question to Users'
	params do
		requires :token, type: String, regexp: UUID_REGEX
	end
	post :send_question, jbuilder: 'ios_marketiq' do
		if current_user.role == 'Jobseeker'
			@marketiq = Marketiq.where(role: 1).where(specialization_id: current_user.user_educations.pluck('specialization_id')).order("RANDOM()").first
		elsif current_user.role == 'Company'        
			@marketiq = Marketiq.where(role: 2).where(industry_id: current_user.industry_id).order("RANDOM()").first
		elsif current_user.role == 'Student'        
			@marketiq = Marketiq.where(role: 3).where(award_name: current_user.user_awards.pluck('name')).order("RANDOM()").first
		elsif current_user.role == 'Faculty'        
			@marketiq = Marketiq.where(role: 4).where(subject: current_user.faculty_affiliations.pluck('subject')).order("RANDOM()").first
		end
		if @marketiq
			@user_marketiq = UserMarketiq.new user_id: current_user.id, marketiq_id: @marketiq.id
			error! @user_marketiq.errors.full_messages.join(', '),422 unless @user_marketiq.save
		end
	end
	desc 'Send Answer Of Marketiq Question'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_marketiq_id
		requires :answer
	end
	post :send_answer, jbuilder: 'ios_marketiq' do
		@answer_user_marketiq = UserMarketiq.find params[:user_marketiq_id]
		@answer_user_marketiq.answer = params[:answer]
		@answer_user_marketiq.status = true
		error! @answer_user_marketiq.errors.full_messages.join(', '),422 unless @answer_user_marketiq.save
	end
	desc 'Users Market IQ List'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :list, jbuilder: 'ios_marketiq' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_marketiqs = @find_user.user_marketiqs
		error! @user_marketiqs.errors.full_messages.join(', '),422 unless @user_marketiqs
	end
end
#--------------------------------marketiq end----------------------------------#
#--------------------------------folder start----------------------------------#
resources :folder do
	before { authenticate! }
	desc 'Create Folder'
  params do
    requires :token, type: String, regexp: UUID_REGEX
    requires :name
  end
  post :create, jbuilder: 'android_folder' do
    @a = UserFolder.joins(:folder).where("user_folders.user_id = ?", current_user.id).where('folders.name = ?', params[:name].downcase).first
    if @a
      error! 'Folder name already exist! Please try another one!', 422
    else
      @folder = Folder.new name: params[:name].downcase, default_status: false
      error! @folder.errors.full_messages.join(', '), 422 unless @folder.save
      @user_folder = UserFolder.new user_id: current_user.id
      @user_folder.folder_id = @folder.id
      error! @user_folder.errors.full_messages.join(', '), 422 unless @user_folder.save
    end          
  end
	desc 'List Folder'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :listing, jbuilder: 'ios_folder' do
		@find_user = User.find params[:user_id]
		error! 'User not found',422 unless @find_user
		@user_folders = @find_user.user_folders
		error! @user_folders.errors.full_messages.join(', '),422 unless @user_folders
	end
	desc 'Edit folder'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :folder_id
		optional :name
	end
	post :edit, jbuilder: 'ios_folder' do
		@folder = Folder.find params[:folder_id]
		error! 'Folder not found',422 unless @folder
		@folder.attributes = clean_params(params).permit(:name)
		error! @folder.errors.full_messages.join(', '),422 unless @folder.save
	end
	desc 'Delete folder'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :folder_id
	end
	post :delete do
		@user_folder = UserFolder.where(user_id: current_user.id).where(folder_id: params[:folder_id]).first
		error! 'Folder not found',422 unless @user_folder
		if @user_folder.folder.default_status == false
			@user_folder.user_favourites.destroy_all
			@user_folder.destroy
			status 200
		else
			error! 'You cant delete default folder',422
		end
	end  
	desc 'Delete folder user'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :user_id
	end
	post :delete_favourite_user do
		@user_fav = UserFavourite.where(user_id: current_user.id).where(favourite_id: params[:user_id]).first
		error! 'Favourite User not found',422 unless @user_fav
		@user_fav.destroy
		status 200
	end
	desc 'Move folder user'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :old_folder_id
		requires :new_folder_id
		requires :user_id
	end
	post :move_fav_user do
		@user_fav = UserFavourite.where(favourite_id: params[:user_id]).where(folder_id: params[:old_folder_id]).first
		error! 'Favourite User not found',422 unless @user_fav
		@user_fav.folder_id = params[:new_folder_id]
		error! @user_fav.errors.full_messages.join(', '),422 unless @user_fav.save
		status 200
	end
	desc 'View folder'
	params do
		requires :token, type: String, regexp: UUID_REGEX
		requires :folder_id
	end
	post :view, jbuilder: 'ios_folder' do
		@my_folder = UserFolder.find params[:folder_id]
		error!({error: 'Folder not found', status: 'Fail'}, 200) unless @my_folder
	end
end
#--------------------------------folder end----------------------------------#
#--------------------------------graph start----------------------------------#
resources :graph do
#before { authenticate! }
desc 'Search For Graph'
params do
	requires :token, type: String, regexp: UUID_REGEX
	requires :country_name
	requires :category_name
end
post :search, jbuilder: 'ios_notification' do
	@stock = CompanyStock.joins(:category,:stock_country).where('stock_countries.name = ?', params[:country_name]).where('categories.name = ?', params[:category_name]).first
	error! 'No record found',422 unless @stock
	if !params[:country_name].empty? && !params[:category_name].empty?
		@host = 'https://www.google.com/finance/info'
		@json_array = {
			"q" => @stock.sensex + ":" + @stock.company_code
		} 
		uri = URI.parse(@host)
		uri.query = URI.encode_www_form(@json_array)
		http = Net::HTTP.new(uri.host, uri.port)      
		http.use_ssl = true          
		request = Net::HTTP::Get.new(uri, 'Content-Language' => 'en-us')
		response = http.request(request)
		@parsed_response = JSON.parse(response.body.gsub('//',''))
	else
		error! 'Something went wrong',422
	end
end
end
#--------------------------------graph end----------------------------------#
#--------------------------------search start----------------------------------#
resources :search do
  before { authenticate! }
  desc 'Search Jobseeker'
  params do
	  requires :token, type: String, regexp: UUID_REGEX
	  requires :q
	  requires :course
	  requires :role
	  optional :country_id
	  optional :age
	  optional :gender
	  optional :salary
	  optional :view
	  optional :rating
	  optional :job_type
  end
  post :user, jbuilder: 'ios_search' do
    @search = User.search build_query
    @records = @search.records
  end
end
#--------------------------------search end----------------------------------#
end
