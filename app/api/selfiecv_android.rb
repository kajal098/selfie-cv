require 'api_logger'

class SelfiecvAndroid < Grape::API

  use ApiLogger
  version 'android', using: :path
  format :json 
  formatter :json, Grape::Formatter::Jbuilder

  # Send Validation Error with 200 status code
  rescue_from :all do |e|
    error!({error: e.message, status: 'Fail'}, 200)
  end

  # Default status on 500 Error
  default_error_status 200

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
      error!({error: 'Unauthorized', status: 'Fail'}, 200) unless params[:token] =~ UUID_REGEX
      error!({error: 'Unauthorized', status: 'Fail'}, 200) unless current_user
    end
    
  end
  #--------------------------------devices start----------------------------------#
  resources :devices do


      desc 'Register device after notification service subscription'
      params do
        requires :uuid, type: String
        requires :registration_id, type: String
        requires :device_type, type: String
      end
      post :register do
        @device = Device.find_or_initialize_by uuid: params[:uuid]
        @device.registration_id = params[:registration_id]
        @device.device_type = params[:device_type]
        @device.renew_token
        error! @device.errors.full_messages.join(', '), 200 unless @device.save
        @device.ensure_duplicate_registrations
        { token: @device.token, :status => "Success" }
      end

      desc 'Deactivate device for notifications'
      params do
        requires :token, type: String, regexp: UUID_REGEX
      end
      post :unsubscribe do
        @device = Device.find_by token: params[:token]
        @device.registration_id = nil
        @device.save
        { token: @device.token, :status => "Success" }
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
      post :register, jbuilder: 'android' do
        @user = User.new clean_params(params).permit(:username, :email, :password, :password_confirmation, :role)
        error!({error: 'Device not registered', status: 'Fail'}, 200) unless current_device
        error!({error: 'password not matched', status: 'Fail'}, 200) if params[:password] != params[:password_confirmation]
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
        UserMailer.welcome(@user, @password).deliver_now
        { code: 200, :status => "Success" }
        if @user.role == 'Jobseeker' || @user.role == 'Company'
          @names = ['IT', 'Politics', 'Sports']
          @names.each do |name|
            @folder = Folder.new name: name, default_status: true
            error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @folder.save
            @user_folder = UserFolder.new user_id: @user.id, folder_id: @folder.id
            error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_folder.save
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
      post :login , jbuilder: 'android' do
        @user = User.find_by username: params[:username]
        error!({error: 'Device not registered', status: 'Fail'}, 200) unless current_device
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        error!({error: 'Your account has been deactivated', status: 'Fail'}, 200) unless @user.active == true
        error!({error: 'Authentication failed', status: 'Fail'}, 200) unless @user.role == params[:role]
        error!({error: 'Wrong username or password', status: 'Fail'}, 200) unless @user.valid_password? params[:password]
        current_device.update_column :user_id, @user.id
      end

      desc 'Send reset password token'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :email
      end
      post :reset_code do
        if
          @user = User.find_by_email(params[:email])
          error!({error: 'User not found', status: 'Fail'}, 200) unless @user
          @user.update_column :reset_code, (SecureRandom.random_number*1000000).to_i
          #UserMailer.send_reset_code(@user).deliver_now
          { code: @user.reset_code, :status => "Success" }
        else
          error!({error: 'User does not exist', status: 'Fail'}, 200)
        end
      end

      desc 'Resend reset password token'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :email
      end
      post :resend_reset_code do
        if
          @user = User.find_by_email(params[:email])
          error!({error: 'User not found', status: 'Fail'}, 200) unless @user
          @code = @user.reset_code
          #UserMailer.send_reset_code(@user).deliver_now
          { code: @code, :status => "Success" }
        else
          error!({error: 'User does not exist', status: 'Fail'}, 200)
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
        error!({error: 'Wrong reset code.', status: 'Fail'}, 200) unless @user
        error!({error: 'Password not same as previous password.', status: 'Fail'}, 200) if @user.valid_password?(params[:password])
        error!({error: 'password not matched', status: 'Fail'}, 200) if params[:password] != params[:password_confirmation]
        @user.attributes = clean_params(params).permit(:password, :password_confirmation)
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
        { msg: 'Your password has been changed ..!!', :status => "Success" }
      end

      desc 'Change Password'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :current_password, type: String
        requires :password, type: String
        requires :password_confirmation, type: String
      end
      post :change_password  , jbuilder: 'android' do
        authenticate!
        @user = current_user
        error!({error: 'Current password is wrong.', status: 'Fail'}, 200) unless @user.valid_password? params[:current_password]
        error!({error: 'Password not same as previous password.', status: 'Fail'}, 200) if @user.valid_password?(params[:password])
        error!({error: 'password not matched', status: 'Fail'}, 200) if params[:password] != params[:password_confirmation]
        @user.attributes = clean_params(params).permit(:password, :password_confirmation)
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
      end

      # desc 'Send Delete Code To User'
      # params do
      #   requires :token, type: String, regexp: UUID_REGEX
      # end
      # post :send_delete_account_code do
      #   authenticate!
      #   @user = current_user
      #   @user.update_column :delete_code, (SecureRandom.random_number*1000000).to_i
      #   UserMailer.send_ac_delete_code(@user).deliver_now
      #   { code: 200, :status => "Success" }
      # end

      # desc 'Delete User Account'
      # params do
      #   requires :token, type: String, regexp: UUID_REGEX
      #   requires :delete_code
      # end
      # post :delete_account do
      #   authenticate!
      #   @user = User.find_by_delete_code(params[:delete_code])
      #   error!({error: 'Wrong delete code.', status: 'Fail'}, 200) unless @user 
      #   @user.destroy
      #   { code: 200, :status => "Success" }
      # end

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
        { code: 200, :status => "Success" }
      end

      desc 'Reactivate User Account'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :username
      end
      post :reactivate_user_account do
        @user = User.find_by_username(params[:username])
        error!({error: 'Wrong delete code.', status: 'Fail'}, 200) unless @user 
        @user.active = true
        @user.save
        UserMailer.send_ac_reactivate_mail(@user).deliver_now
        { code: 200, :status => "Success" }
      end

      desc 'All stuff'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :all_stuff , jbuilder: 'android_all_stuff' do
        authenticate!
        @user_stuff = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user_stuff      
      end

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
        optional :text_field
        optional :file_type
      end
      post :resume, jbuilder: 'android'  do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name, :last_name, :gender,
        :date_of_birth, :nationality, :address, :city, :zipcode, :country_id,  :contact_number, :file_type, :text_field)
        if (params[:file_type] == 'text')
          @user.text_field = params[:text_field] if params[:text_field]
        else
          @user.file = params[:file] if params[:file]
        end
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
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
        optional :text_field
        optional :file_type
      end
      post :update_resume, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name,
        :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :country_id,
        :contact_number, :file_type, :text_field)
        if (params[:file_type] == 'text')
          @user.text_field = params[:text_field] if params[:text_field]
        else
          @user.file = params[:file] if params[:file]
        end
        @user.update_cv_count += 1
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
      end

      desc 'Get User Resume'
      params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      end
      post :get_user_resume, jbuilder: 'android' do
      authenticate!
      @user = User.find params[:user_id]
      error!({error: 'User not found', status: 'Fail'}, 200) unless @user
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
      post :education, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_education = UserEducation.new user_id: @user.id
        if (params[:course_id] || params[:specialization_id] || params[:year] || params[:school] || params[:skill] )
          @user_education.attributes = clean_params(params).permit(:course_id, :specialization_id,  :year, :school, :skill)
          error!({error: @user_education.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_education.save
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
      post :update_education, jbuilder: 'android' do
        authenticate!
        @user_education = UserEducation.find params[:education_id]
        error!({error: 'User Education not found', status: 'Fail'}, 200) unless @user_education
        @user_education.attributes = clean_params(params).permit(:course_id, :specialization_id, :year,
        :school, :skill)
        error!({error: @user_education.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_education.save
        @user_education
      end


      desc 'Get Users Education Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_educations, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_educations = @user.user_educations
      end

      desc 'Delete Education'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :education_id
      end
      post :delete_education do
        authenticate!
        @education = UserEducation.find params[:education_id]
        error!({error: 'User Education not found', status: 'Fail'}, 200) unless @education
        @education.destroy
        { code: 200, :status => "Success" }
      end

      desc 'User Experience'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :name
        requires :exp_type
        optional :start_from
        optional :working_till
        optional :designation
        optional :description
        requires :current_company
        optional :file
        optional :text_field
        optional :file_type
      end
      post :experiences, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_experience = UserExperience.new user_id: @user.id
        @user_experience.attributes = clean_params(params).permit(:name, :start_from,  :working_till, :designation, :description, :current_company, :file_type, :text_field)
        if (params[:file_type] == 'text')
          @user_experience.text_field = params[:text_field] if params[:text_field]
        else
          @user_experience.file = params[:file] if params[:file]
        end
        error!({error: @user_experience.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_experience.save
      end

      desc 'Update User Experience'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :experience_id
        optional :name
        optional :start_from
        optional :working_till
        optional :designation
        optional :description
        optional :file
        optional :text_field
        optional :file_type
      end
      post :update_experience, jbuilder: 'android' do
        authenticate!
        @user_experience = UserExperience.find params[:experience_id]
        error!({error: 'User Experience not found', status: 'Fail'}, 200) unless @user_experience
        @user_experience.attributes = clean_params(params).permit(:name, :start_from, :working_till,
        :designation, :description, :file_type, :text_field)
        if (params[:file_type] == 'text')
          @user_experience.text_field = params[:text_field] if params[:text_field]
        else
          @user_experience.file = params[:file] if params[:file]
        end
        error!({error: @user_experience.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_experience.save
      end

      desc 'Get Users Experience Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_experiences, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_experiences = @user.user_experiences
      end

      desc 'Delete Experience'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :experience_id
      end
      post :delete_experience do
        authenticate!
        @experience = UserExperience.find params[:experience_id]
        error!({error: 'User Experience not found', status: 'Fail'}, 200) unless @experience
        @experience.destroy
        { code: 200, :status => "Success" }
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
      post :preferred_work, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:ind_name] || params[:functional_name] || params[:preferred_designation] || params[:preferred_location] || params[:current_salary] || params[:expected_salary] || params[:time_type] )
          @user_preferred_work = UserPreferredWork.new user_id: @user.id
          @user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
          error!({error: @user_preferred_work.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_preferred_work.save
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
      post :update_preferred_work, jbuilder: 'android' do
        authenticate!
        @user_preferred_work = UserPreferredWork.find params[:preferred_work_id]
        error!({error: 'User Preffered Work not found', status: 'Fail'}, 200) unless @user_preferred_work
        @user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
        error!({error: @user_preferred_work.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_preferred_work.save
        @user_preferred_work
      end

      desc 'Get Users Preferred Work'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_preferred_works, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_preferred_works = @user.user_preferred_works
      end

      desc 'Delete Preffered Work'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :preffered_work_id
      end
      post :delete_preffered_work do
        authenticate!
        @preffered_work = UserPreferredWork.find params[:preffered_work_id]
        error!({error: 'User Preffered Work not found', status: 'Fail'}, 200) unless @preffered_work
        @preffered_work.destroy
        { code: 200, :status => "Success" }
      end

      desc 'User Award'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        optional :name        
        optional :description        
        optional :file
        optional :text_field
        optional :file_type
      end
      post :award, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:name] || params[:descrption] )
          @award = UserAward.new user_id: @user.id
          @award.attributes = clean_params(params).permit(:name, :description, :file_type, :text_field)
              if (params[:file_type] == 'text')
                  @award.text_field = params[:text_field] if params[:text_field]
              else
                  @award.file = params[:file] if params[:file]
              end
          error!({error: @award.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @award.save
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
        optional :text_field
        optional :file_type
      end
      post :update_award, jbuilder: 'android' do
      authenticate!
        @award = UserAward.find params[:award_id]
        error!({error: 'User Award not found', status: 'Fail'}, 200) unless @award
        @award.attributes = clean_params(params).permit(:name, :description, :file_type, :text_field)
        if (params[:file_type] == 'text')
        @award.text_field = params[:text_field] if params[:text_field]
        else
        @award.file = params[:file] if params[:file]
        end
        error!({error: @award.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @award.save
      end

      desc 'Get Users Award'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_award, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_awards = @user.user_awards
      end

      desc 'Delete Award'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :award_id
      end
      post :delete_award do
        authenticate!
        @award = UserAward.find params[:award_id]
        error!({error: 'User Award not found', status: 'Fail'}, 200) unless @award
        @award.destroy
        { code: 200, :status => "Success" }
      end

      desc 'User Certificate'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        optional :name
        optional :year
        optional :certificate_type        
        optional :file
        optional :text_field
        optional :file_type
      end
      post :certificate, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:name] || params[:year] || params[:certificate_type] )
          @certificate = UserCertificate.new user_id: @user.id
          @certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type, :file_type, :text_field)
              if (params[:file_type] == 'text')
                  @certificate.text_field = params[:text_field] if params[:text_field]
              else
                  @certificate.file = params[:file] if params[:file]
              end
          error!({error: @certificate.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @certificate.save
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
        optional :text_field
        optional :file_type
      end
      post :update_certificate, jbuilder: 'android' do
        authenticate!
        @certificate = UserCertificate.find params[:certificate_id]
        error!({error: 'User Certificate not found', status: 'Fail'}, 200) unless @certificate
        @certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type, :file_type, :text_field)
            if (params[:file_type] == 'text')
                @certificate.text_field = params[:text_field] if params[:text_field]
            else
                @certificate.file = params[:file] if params[:file]
            end
        error!({error: @certificate.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @certificate.save
      end

      desc 'Get Users Certificate Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_certificates, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_certificates = @user.user_certificates
      end

      desc 'Delete Certificate'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :certificate_id
      end
      post :delete_certificate do
        authenticate!
        @certificate = UserCertificate.find params[:certificate_id]
        error!({error: 'User Certificate not found', status: 'Fail'}, 200) unless @certificate
        @certificate.destroy
        { code: 200, :status => "Success" }
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
        optional :hobby
        optional :file
        optional :text_field
        optional :file_type
      end
      post :curriculars, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:curricular_type] || params[:title] || params[:team_type] || params[:location] || params[:date] || params[:hobby] )
          @curricular = UserCurricular.new user_id: @user.id
          @curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date, :hobby, :file_type, :text_field)
              if (params[:file_type] == 'text')
                  @curricular.text_field = params[:text_field] if params[:text_field]
              else
                  @curricular.file = params[:file] if params[:file]
              end
          error!({error: @curricular.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @curricular.save
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
        optional :hobby
        optional :file
        optional :text_field
        optional :file_type
      end
      post :update_curricular, jbuilder: 'android' do
        authenticate!
        @curricular = UserCurricular.find params[:curricular_id]
        error!({error: 'User Curricular not found', status: 'Fail'}, 200) unless @curricular
        @curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date, :hobby, :file_type, :text_field)
            if (params[:file_type] == 'text')
                @curricular.text_field = params[:text_field] if params[:text_field]
            else
                @curricular.file = params[:file] if params[:file]
            end
        error!({error: @curricular.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @curricular.save
      end

      desc 'Get Users Curriculars Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_curriculars, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_curriculars = @user.user_curriculars
      end

      desc 'Delete Curricular'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :curricular_id
      end
      post :delete_curricular do
        authenticate!
        @curricular = UserCurricular.find params[:curricular_id]
        error!({error: 'User Curricular not found', status: 'Fail'}, 200) unless @curricular
        @curricular.destroy
        { code: 200, :status => "Success" }
      end

      desc 'User Future Goal'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :goal_type
        optional :title
        optional :term_type        
        optional :file
        optional :text_field
        optional :file_type
      end
      post :future_goal, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:goal_type] || params[:title] || params[:term_type] )
          @future_goal = UserFutureGoal.new user_id: @user.id
          @future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type, :file_type, :text_field)
              if (params[:file_type] == 'text')
                  @future_goal.text_field = params[:text_field] if params[:text_field]
              else
                  @future_goal.file = params[:file] if params[:file]
              end
          error!({error: @future_goal.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @future_goal.save
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
        optional :text_field
        optional :file_type
      end
      post :update_future_goal, jbuilder: 'android' do
        authenticate!
        @future_goal = UserFutureGoal.find params[:update_future_goal_id]
        error!({error: 'User Future Goal not found', status: 'Fail'}, 200) unless @future_goal
        @future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type, :file_type, :text_field)
            if (params[:file_type] == 'text')
                @future_goal.text_field = params[:text_field] if params[:text_field]
            else
                @future_goal.file = params[:file] if params[:file]
            end
        error!({error: @future_goal.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @future_goal.save
      end

      desc 'Get Users Future Goals Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_future_goals, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_future_goals = @user.user_future_goals
      end
      

      desc 'Delete Future Goal'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :future_goal_id
      end
      post :delete_future_goal do
        authenticate!
        @future_goal = UserFutureGoal.find params[:future_goal_id]
        error!({error: 'User Future Goal not found', status: 'Fail'}, 200) unless @future_goal
        @future_goal.destroy
        { code: 200, :status => "Success" }
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
      post :working_environment, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:env_type] || params[:title] )
          @environment = UserEnvironment.new user_id: @user.id
          @environment.attributes = clean_params(params).permit(:env_type, :title, :file_type, :text_field)
              if (params[:file_type] == 'text')
                  @environment.text_field = params[:text_field] if params[:text_field]
              else
                  @environment.file = params[:file] if params[:file]
              end
          error!({error: @environment.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @environment.save
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
      post :update_working_environment, jbuilder: 'android' do
        authenticate!
        @environment = UserEnvironment.find params[:environment_id]
        error!({error: 'User Environment not found', status: 'Fail'}, 200) unless @environment
        @environment.attributes = clean_params(params).permit(:env_type, :title, :file_type, :text_field)
            if (params[:file_type] == 'text')
                @environment.text_field = params[:text_field] if params[:text_field]
            else
                @environment.file = params[:file] if params[:file]
            end
        error!({error: @environment.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @environment.save
      end

      desc 'Get Users Working Environments Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_working_environments, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_working_environments = @user.user_environments
      end
      

      desc 'Delete Work Environment'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :work_env_id
      end
      post :delete_work_env do
        authenticate!
        @work_env = UserEnvironment.find params[:work_env_id]
        error!({error: 'User Environment not found', status: 'Fail'}, 200) unless @work_env
        @work_env.destroy
        { code: 200, :status => "Success" }
      end

      desc 'User References'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
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
      post :references, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @reference = UserReference.new user_id: @user.id
        if (params[:title] || params[:ref_type] || params[:from] || params[:email] || params[:contact] || params[:date] || params[:location] )
          @reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location, :file_type, :text_field)
              if (params[:file_type] == 'text')
                  @reference.text_field = params[:text_field] if params[:text_field]
              else
                  @reference.file = params[:file] if params[:file]
              end
          error!({error: @reference.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @reference.save
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
      post :update_references, jbuilder: 'android' do
        authenticate!
        @reference = UserReference.find params[:reference_id]
        error!({error: 'User Reference not found', status: 'Fail'}, 200) unless @reference
        @reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location, :file_type, :text_field)
            if (params[:file_type] == 'text')
                @reference.text_field = params[:text_field] if params[:text_field]
            else
                @reference.file = params[:file] if params[:file]
            end
        error!({error: @reference.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @reference.save
      end

      desc 'Get Users References Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_references, jbuilder: 'android' do
        authenticate!
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_references = @user.user_references
      end
      

      desc 'Delete reference'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :reference_id
      end
      post :delete_reference do
        authenticate!
        @reference = UserReference.find params[:reference_id]
        error!({error: 'User References not found', status: 'Fail'}, 200) unless @reference
        @reference.destroy
        { code: 200, :status => "Success" }
      end
  end
  #--------------------------------member end----------------------------------#
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
      post :company_info, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if @user.role == 'Company'
            @user.attributes = clean_params(params).permit(:company_name, :company_establish_from, :industry_id,
            :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id, :company_id, :country_id)
            error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
        else
            error!({error: 'Record not found', status: 'Fail'}, 200)
        end
      end

      desc 'Company Introduction'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :company_logo
        requires :company_logo_type
        optional :company_profile
        optional :company_profile_type
        optional :company_brochure        
        optional :company_brochure_type
        requires :company_website
        requires :company_facebook_link
      end
      post :corporate_identity, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if @user.role == 'Company'
            @user.attributes = clean_params(params).permit(:company_website, :company_facebook_link, :company_logo_type, :company_profile_type, :company_brochure_type)
            @user.company_logo = params[:company_logo] if params[:company_logo]
            @user.company_profile = params[:company_profile] if params[:company_profile]
            @user.company_brochure = params[:company_brochure] if params[:company_brochure]
            error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
        else
            error!({error: 'Record not found', status: 'Fail'}, 200)
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
      post :evalution_information, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if @user.role == 'Company'
            @user.attributes = clean_params(params).permit(:company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures )
            error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
        else
            error!({error: 'Record not found', status: 'Fail'}, 200)
        end
      end

      desc 'Get Company Evalution Information'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :company_id
      end
      post :get_company_information, jbuilder: 'android' do
        @user = User.find params[:company_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
      end

      desc 'Company Future Goal'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        optional :company_future_turnover
        optional :company_future_new_venture_location
        optional :company_future_outlet
      end
      post :future_goal, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if @user.role == 'Company'
            @user.attributes = clean_params(params).permit(:company_future_turnover, :company_future_new_venture_location, :company_future_outlet)
            error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
        else
            error!({error: 'Record not found', status: 'Fail'}, 200)
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
        requires :country_id
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
      post :edit_company, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user.attributes = clean_params(params).permit(:company_name, :company_establish_from, :industry_id,
        :company_functional_area, :company_address, :company_zipcode, :company_city, :country_id, :company_contact, :company_skype_id, :company_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet, :company_logo_type, :company_profile_type, :company_brochure_type)
        @user.company_logo = params[:company_logo] if params[:company_logo]
        @user.company_profile = params[:company_profile] if params[:company_profile]
        @user.company_brochure = params[:company_brochure] if params[:company_brochure]
        @user.update_cv_count += 1
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
      end

      desc 'Company Galery'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :files, type: Array, default: []
      end
      post :galery, jbuilder: 'android_galery' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        params[:files].each do |file|
          @galery = CompanyGalery.new user_id: params[:user_id]
          @galery.file = file
          error!({error: @galery.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @galery.save
          @galeries = @user.company_galeries
        end      
      end

      desc 'Company Galery Listing'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :galery_listing, jbuilder: 'android_galery' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @galeries = @user.company_galeries
      end

      desc 'Company Galery  Delete Multiple Photos'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :delete_ids, type: Array, default: []
      end
      post :delete_photos, jbuilder: 'android_galery' do
        params[:delete_ids].each do |delete_id|
          @galery = CompanyGalery.find delete_id
          error!({error: 'Something went wrong.Please try again.!', status: 'Fail'}, 200) unless @galery.destroy
        end   
        { code: 200, :status => "Success" }  
      end
  end
  #--------------------------------company end----------------------------------#
  #--------------------------------data start----------------------------------#
  resources :data do 
  before { authenticate! }

      desc 'Dropdown Data'
      params do
        requires :token, type: String, regexp: UUID_REGEX
      end
      post :all_data, jbuilder: 'android' do
        @courses = Course.all
        @specializations = Specialization.all
        @companies = Company.all
        @industries = Industry.all
        @companystocks = CompanyStock.all
      end

      desc 'Update Image'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        optional :profile_pic
        optional :back_profile
      end
      post :update_image, jbuilder: 'android' do
        @update_image = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @update_image
        @update_image.profile_pic = params[:profile_pic] if params[:profile_pic]
        @update_image.back_profile = params[:back_profile] if params[:back_profile]
        error!({error: @update_image.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @update_image.save
      end

      desc 'Video For Appflow'
      params do
        requires :token, type: String, regexp: UUID_REGEX
      end
      post :video, jbuilder: 'android' do
        @video = VideoUpload.last
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
        requires :first_name
        optional :last_name
        optional :gender  
        optional :date_of_birth 
        optional :nationality 
        optional :address 
        optional :city
        optional :zipcode
        requires :country_id
        requires :contact_number
        optional :file
        optional :file_type
      end
      post :basic_info, jbuilder: 'android' do
        @basic_info = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @basic_info
        @basic_info.attributes = clean_params(params).permit(:first_name,  :last_name, :gender,
        :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type, :text_field)
        @basic_info.file = params[:file] if params[:file]
        error!({error: @basic_info.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @basic_info.save
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
      post :update_basic_info, jbuilder: 'android' do
        @basic_info = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @basic_info
        @basic_info.attributes = clean_params(params).permit(:first_name, :last_name, :gender,
        :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type, :text_field)
        @basic_info.file = params[:file] if params[:file]
        @basic_info.update_cv_count += 1
        error!({error: @basic_info.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @basic_info.save
      end

      desc 'Get Basic Info'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_basic_info, jbuilder: 'android' do
        @basic_info = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @basic_info
      end

      desc 'Student Education'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :standard
        optional :school
        optional :year
      end
      post :student_education, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:standard] || params[:school] || params[:year] )
          @student_education = StudentEducation.new user_id: @user.id
          @student_education.attributes = clean_params(params).permit(:standard, :school, :year)
          error!({error: @student_education.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @student_education.save
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
      post :update_student_education, jbuilder: 'android' do
        @student_education = StudentEducation.find params[:education_id]
        error!({error: 'Student education not found', status: 'Fail'}, 200) unless @student_education
        @student_education.attributes = clean_params(params).permit(:standard, :school, :year)
        @student_education.file = params[:file] if params[:file]
        error!({error: @student_education.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @student_education.save
      end
      

      desc 'Delete Student Education'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :education_id
      end
      post :delete_student_education do
        @student_education = StudentEducation.find params[:education_id]
        error!({error: 'Student Education not found', status: 'Fail'}, 200) unless @student_education
        @student_education.destroy
        { code: 200, :status => "Success" }
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
      post :student_marksheet, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:school_name] || params[:standard] || params[:grade] || params[:year] )
          @student_marksheet = UserMarksheet.new user_id: @user.id
          @student_marksheet.attributes = clean_params(params).permit(:school_name, :standard, :grade, :year, :file_type)
          @student_marksheet.file = params[:file] if params[:file]
          error!({error: @student_marksheet.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @student_marksheet.save
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
      post :update_student_marksheet, jbuilder: 'android' do
        @student_marksheet = UserMarksheet.find params[:marksheet_id]
        error!({error: 'Student marksheet not found', status: 'Fail'}, 200) unless @student_marksheet
        @student_marksheet.attributes = clean_params(params).permit(:school_name, :standard, :grade, :year, :file_type)
        @student_marksheet.file = params[:file] if params[:file]
        error!({error: @student_marksheet.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @student_marksheet.save
      end
      

      desc 'Delete Student Marksheet'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :marksheet_id
      end
      post :delete_student_marksheet do
        @student_marksheet = UserMarksheet.find params[:marksheet_id]
        error!({error: 'Student Marksheet not found', status: 'Fail'}, 200) unless @student_marksheet
        @student_marksheet.destroy
        { code: 200, :status => "Success" }
      end

      desc 'Student Project'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :title
        optional :description
      end
      post :student_project, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:title] || params[:description] )
          @student_project = UserProject.new user_id: @user.id
          @student_project.attributes = clean_params(params).permit(:title, :description)
          error!({error: @student_project.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @student_project.save
        end          
      end

      desc 'Update Student Project'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :project_id
        optional :title
        optional :description
      end
      post :update_student_project, jbuilder: 'android' do
        @student_project = UserProject.find params[:project_id]
        error!({error: 'Student Project not found', status: 'Fail'}, 200) unless @student_project
        @student_project.attributes = clean_params(params).permit(:title, :description)
        error!({error: @student_project.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @student_project.save
      end
      

      desc 'Delete Student Project'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :project_id
      end
      post :delete_student_project do
        @student_project = UserProject.find params[:project_id]
        error!({error: 'User Project not found', status: 'Fail'}, 200) unless @student_project
        @student_project.destroy
        { code: 200, :status => "Success" }
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
        requires :contact_number
        optional :file
        optional :text_field
        optional :file_type
      end
      post :basic_info, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user.attributes = clean_params(params).permit(:first_name,  :middle_name, :last_name, :gender,
        :date_of_birth, :nationality, :address, :city, :zipcode, :country_id,  :contact_number, :file_type)
        if (params[:file_type] == 'text')
            @user.text_field = params[:text_field] if params[:text_field]
        else
            @user.file = params[:file] if params[:file]
        end
        @user.update_cv_count += 1
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
      end

      desc 'Faculty Resume'
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
        requires :country_id
        optional :zipcode
        optional :contact_number
        optional :file
        optional :text_field
        optional :file_type
      end
      post :edit_basic_info, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user.attributes = clean_params(params).permit(:first_name,  :middle_name, :last_name, :gender,
        :date_of_birth, :nationality, :address, :city, :country_id, :zipcode,  :contact_number, :file_type)
        if (params[:file_type] == 'text')
            @user.text_field = params[:text_field] if params[:text_field]
        else
            @user.file = params[:file] if params[:file]
        end
        @user.update_cv_count += 1
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
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
      post :faculty_affiliation, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:collage_name] || params[:subject] || params[:designation] || params[:join_from] || params[:join_till] || params[:file_type] )
          @faculty_affiliation = FacultyAffiliation.new user_id: @user.id
          @faculty_affiliation.attributes = clean_params(params).permit(:university, :collage_name, :subject, :designation, :join_from, :join_till, :file_type)
          @faculty_affiliation.file = params[:file] if params[:file]
          error!({error: @faculty_affiliation.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_affiliation.save
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
      post :update_faculty_affiliation, jbuilder: 'android' do
        @faculty_affiliation = FacultyAffiliation.find params[:affiliation_id]
        error!({error: 'Faculty affiliation not found', status: 'Fail'}, 200) unless @faculty_affiliation
        @faculty_affiliation.attributes = clean_params(params).permit(:university, :collage_name, :subject, :designation, :join_from, :join_till, :file_type)
        @faculty_affiliation.file = params[:file] if params[:file]
        error!({error: @faculty_affiliation.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_affiliation.save
      end
      

      desc 'Delete Faculty Affiliation'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :affiliation_id
      end
      post :delete_faculty_affiliation do
        @faculty_affiliation = FacultyAffiliation.find params[:affiliation_id]
        error!({error: 'Faculty Affiliation not found', status: 'Fail'}, 200) unless @faculty_affiliation
        @faculty_affiliation.destroy
        { code: 200, :status => "Success" }
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
      post :faculty_workshop, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @faculty_workshop = FacultyWorkshop.new user_id: @user.id
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
      post :update_faculty_workshop, jbuilder: 'android' do
        @faculty_workshop = FacultyWorkshop.find params[:workshop_id]
        error!({error: 'Faculty workshop not found', status: 'Fail'}, 200) unless @faculty_workshop
        @faculty_workshop.attributes = clean_params(params).permit(:title, :description, :file_type)
        @faculty_workshop.file = params[:file] if params[:file]
        error!({error: @faculty_workshop.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_workshop.save
      end
      


      desc 'Delete Faculty Workshop'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :workshop_id
      end
      post :delete_faculty_workshop do
        @faculty_workshop = FacultyWorkshop.find params[:workshop_id]
        error!({error: 'Faculty Workshop not found', status: 'Fail'}, 200) unless @faculty_workshop
        @faculty_workshop.destroy
        { code: 200, :status => "Success" }
      end

      desc 'Faculty Publication'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :title
        optional :description
        optional :file
        optional :text_field
        optional :file_type
      end
      post :faculty_publication, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:title] || params[:description] )
          @faculty_publication = FacultyPublication.new user_id: @user.id
          @faculty_publication.attributes = clean_params(params).permit(:title, :description)
              if (params[:file_type] == 'text')
                  @faculty_publication.text_field = params[:text_field] if params[:text_field]
              else
                  @faculty_publication.file = params[:file] if params[:file]
              end
          error!({error: @faculty_publication.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_publication.save
        end          
      end

      desc 'Update Faculty Publication'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :publication_id
        optional :title
        optional :description
        optional :file
        optional :text_field
        optional :file_type
      end
      post :update_faculty_publication, jbuilder: 'android' do
        @faculty_publication = FacultyPublication.find params[:publication_id]
        error!({error: 'Student publication not found', status: 'Fail'}, 200) unless @faculty_publication
        @faculty_publication.attributes = clean_params(params).permit(:title, :description)
        if (params[:file_type] == 'text')
            @faculty_publication.text_field = params[:text_field] if params[:text_field]
        else
            @faculty_publication.file = params[:file] if params[:file]
        end
        error!({error: @faculty_publication.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_publication.save
      end
      

      desc 'Delete Faculty Publication'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :publication_id
      end
      post :delete_faculty_publication do
        @faculty_publication = FacultyPublication.find params[:publication_id]
        error!({error: 'Faculty Publication not found', status: 'Fail'}, 200) unless @faculty_publication
        @faculty_publication.destroy
        { code: 200, :status => "Success" }
      end

      desc 'Faculty Research'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :title
        optional :description
        optional :file
        optional :text_field
        optional :file_type
      end
      post :faculty_research, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:title] || params[:description] )
          @faculty_research = FacultyResearch.new user_id: @user.id
          @faculty_research.attributes = clean_params(params).permit(:title, :description)
              if (params[:file_type] == 'text')
                  @faculty_research.text_field = params[:text_field] if params[:text_field]
              else
                  @faculty_research.file = params[:file] if params[:file]
              end
          error!({error: @faculty_research.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_research.save
        end          
      end

      desc 'Update Faculty Reaserch'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :research_id
        optional :title
        optional :description
        optional :file
        optional :text_field
        optional :file_type
      end
      post :update_faculty_research, jbuilder: 'android' do
        @faculty_research = FacultyResearch.find params[:research_id]
        error!({error: 'Student research not found', status: 'Fail'}, 200) unless @faculty_research
        @faculty_research.attributes = clean_params(params).permit(:title, :description)
        if (params[:file_type] == 'text')
        @faculty_research.text_field = params[:text_field] if params[:text_field]
        else
        @faculty_research.file = params[:file] if params[:file]
        end
        error!({error: @faculty_research.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_research.save
      end
      

      desc 'Delete Faculty Research'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :research_id
      end
        post :delete_faculty_research do
        @faculty_research = FacultyResearch.find params[:research_id]
        error!({error: 'Faculty Research not found', status: 'Fail'}, 200) unless @faculty_research
        @faculty_research.destroy
        { code: 200, :status => "Success" }
      end
  end
  #--------------------------------faculty end----------------------------------#
  #--------------------------------group start----------------------------------#
  resources :group do 
  before { authenticate! }

      desc 'Create Group'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :name
        optional :group_pic
      end
      post :create, jbuilder: 'android_group' do
        @group = Group.new clean_params(params).permit(:name)
        @group.code = Random.rand(500000..900000)
        @group.group_pic = params[:group_pic] if params[:group_pic]
        error!({error: @group.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @group.save
        @group_user = GroupUser.new user_id: current_user.id, group_id: @group.id, admin: true , status: 'joined' 
        error!({error: @group_user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @group_user.save
        @chat = Chat.new
        @chat.sender_id = current_user.id
        @chat.group_id = @group.id
        @chat.activity = "true"
        @chat.quick_msg = "created"
        @chat.save
      end

      desc 'Listing of users Group'
      params do
        requires :token, type: String, regexp: UUID_REGEX
      end
      post :listing, jbuilder: 'android_group' do
        @groups = current_user.all_groups(current_user)
      end

      desc 'Information of Group'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
      end
      post :info, jbuilder: 'android_group' do
        @group = Group.find(params[:group_id])      
        error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
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
        error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
        @group.attributes = clean_params(params).permit(:name)
        @group.group_pic = params[:group_pic] if params[:group_pic]
        error!({error: @group.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @group.save
      end
      

      desc 'Delete Group'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
        optional :user_id
      end
      post :delete do
        @group = Group.find params[:group_id]  
        error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
        if params[:user_id]   
            @user = User.find params[:user_id] 
            @group_user = GroupUser.find_by_user_id params[:user_id]
            error!({error: 'Group User not found', status: 'Fail'}, 200) unless @group_user
            unless @group.deleted_from.include? @user.id
            @group.deleted_from << @user.id
            @group.update_column :deleted_from, @group.deleted_from
            end   
            @group_user.status = 'deleted'
            @group_user.save
            @chat = Chat.new
            @chat.sender_id = current_user.id
            @chat.group_id = @group.id
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
        { code: 200, :status => "Success" }
      end

      desc 'Registered Students'
      params do
        requires :token, type: String, regexp: UUID_REGEX
      end
      post :registered_students, jbuilder: 'android' do
        @students = User.where(role: 1).all
      end      

      desc 'Email invitation'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
        requires :email_ids, type: Array, default: []
      end
      post :email_invite do
        @group = Group.find params[:group_id]
        error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
        params[:email_ids].each do |email|
        @group_invitee = GroupInvitee.new group_id: params[:group_id], email: email
        error!({error: @group_invitee.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @group_invitee.save
        UserMailer.send_group_code(@group,email).deliver_now
        end
        { :status => "Success" }
      end

      desc 'Join Group'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :code
      end
      post :join, jbuilder: 'android_group' do
        @group = Group.find_by_code params[:code]
        error!({error: 'Group not found or wrong code', status: 'Fail'}, 200) unless @group
        @group_invitee = @group.group_invitees.where(email: current_user.email).first
        error!({error: 'You are unauthorized for this group.', status: 'Fail'}, 200) unless @group_invitee
        @group_user = @group.users.where(user_id: current_user.id).first
        error!({error: 'You are already in this group.', status: 'Fail'}, 200) if @group_user
        if @group_invitee.present?
            @group_user = GroupUser.new user_id: current_user.id, group_id: @group.id , admin: false , status: 'joined'
            error!({error: @group_user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @group_user.save      
            @chat = Chat.new
            @chat.sender_id = current_user.id
            @chat.group_id = @group.id
            @chat.activity = "true"
            @chat.quick_msg = "joined"
            @chat.save
            @group.accepted_users.each do |group_user|
            #Device.notify group_user.user.active_devices, { msg: "#{current_user.username} has join to group #{@group}.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
            end
        end      
      end

      desc 'Leave Group'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
      end
      post :leave, jbuilder: 'android_group' do
        @group = Group.find params[:group_id]
        error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
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
      post :quick_message, jbuilder: 'android_message' do
        @messages = QuickMessage.where(role: QuickMessage::ROLES[params[:role]])
      end

      desc 'Search Group Of Current User'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :q
      end
      post :search , jbuilder: 'android_group' do
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
        optional :file
        optional :file_type
        optional :quick_msg_id
        optional :text_value
      end
      post :create, jbuilder: 'android_message' do
        @chat = Chat.new group_id: params[:group_id], sender_id: current_user.id
        @chat.file_type = params[:file_type] if params[:file_type]
        @chat.file = params[:file] if params[:file]
        if params[:quick_msg_id]
            @msg = QuickMessage.find params[:quick_msg_id]
            error!({error: 'Quick Message not found', status: 'Fail'}, 200) unless @msg
            @chat.quick_msg = @msg.text
        else
            @chat.quick_msg = params[:text_value] if params[:text_value]
        end
        error!({error: @chat.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @chat.save     
      end

      desc 'read Message'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
      end
      post :read , jbuilder: 'android_message' do
        @group = Group.find params[:group_id]
        error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
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
      post :listing, jbuilder: 'android_message' do
        @group = Group.find params[:group_id]
        error!({error: 'Group not found', status: 'Fail'}, 200) unless @group
        @chats = @group.chats
        error!({error: @chat.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @chats  
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
      post :create_schedule, jbuilder: 'android_message' do
        @chat_schedule = ChatSchedule.new
        @chat_schedule.name = params[:name] if params[:name]
        @chat_schedule.date = params[:date]
        @chat_schedule.my_time = params[:my_time]
        @chat_schedule.description = params[:description]
        @chat_schedule.info = params[:info] if params[:info]
        @chat_schedule.group_id = params[:group_id]
        error!({error: @chat_schedule.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @chat_schedule.save
        params[:group_id].each do |q|
          @chat = Chat.new
          @chat.group_id = q
          @chat.sender_id = current_user.id
          @chat.chat_schedule_id = @chat_schedule.id
          @chat.save
        end
      end

      desc 'View schedule'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :schedule_id
      end
      post :view_schedule, jbuilder: 'android_message' do
        @chat_schedule = ChatSchedule.find params[:schedule_id]
        error!({error: 'Schedule not found', status: 'Fail'}, 200) unless @chat_schedule
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
          @a = Chat.new sender_id: current_user.id, group_id: group_id
          @a.file_type = params[:file_type] if params[:file_type]
          @a.file = params[:file] if params[:file]
          error!({error: @a.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @a.save
        end
      end
  end
  #--------------------------------message end----------------------------------#
  #--------------------------------notification start----------------------------------#
  resources :notifications do
  before { authenticate! }

      desc 'Like Profile'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :like_id
        requires :is_liked
      end
      post :like, jbuilder: 'android_notification' do
        if params[:is_liked] == 'false'
            @user_like = UserLike.new user_id: current_user.id, like_id: params[:like_id]
            @user_like.is_liked = 'true'
            error!({error: @user_like.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_like.save     
            #Device.notify User.find(params[:like_id]).active_devices, { msg: "#{current_user.username} liked your profile.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
        else        
            error!({error: 'You already like this profile!', status: 'Fail'}, 200)
        end
        { code: 200, status: 'Success'}
      end

      desc 'View Profile'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :view_id
      end
      post :view, jbuilder: 'android_notification' do
        @user_view = UserView.new user_id: current_user.id, view_id: params[:view_id]
        error!({error: @user_view.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_view.save     
        #Device.notify User.find(params[:view_id]).active_devices, { msg: "#{current_user.username} viewed your profile.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
        { code: 200, status: 'Success'}
      end

      desc 'Share Profile'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :share_id
        requires :share_type
      end
      post :share, jbuilder: 'android_notification' do
        @user_share = UserShare.new user_id: current_user.id, share_id: params[:share_id], share_type: params[:share_type]
        error!({error: @user_share.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_share.save     
        #Device.notify User.find(params[:share_id]).active_devices, { msg: "#{current_user.username} shared your profile on #{params[:share_type]}.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
        { code: 200, status: 'Success'}
      end

      desc 'Favourite Profile'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :favourite_id
        requires :folder_name
        requires :is_favourited
      end
      post :favourite, jbuilder: 'android_notification' do
          if UserFolder.joins(:folder).where("user_folders.user_id = ?", current_user.id).where('folders.name = ?', params[:folder_name]).count > 0
            @folder = Folder.find_by name: params[:folder_name]
          else
            @folder = Folder.new name: params[:folder_name], default_status: false
            error!({error: @folder.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @folder.save
          end
            @user_folder = UserFolder.new user_id: current_user.id, folder_id: @folder.id
            error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_folder.save          
          if params[:is_favourited] == 'false'
              @user_favourite = UserFavourite.new user_id: current_user.id, favourite_id: params[:favourite_id], folder_id: @folder.id
              @user_favourite.is_favourited = 'true'
              error!({error: @user_favourite.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_favourite.save     
          else        
              error!({error: 'You already favourite this profile!', status: 'Fail'}, 200)
          end
      end

      desc 'Rate Profile'
      params do
          requires :token, type: String, regexp: UUID_REGEX
          requires :rate_id
          requires :rate_type
      end
      post :rate, jbuilder: 'android_notification' do
        @user_rate = UserRate.new user_id: current_user.id, rate_id: params[:rate_id], rate_type: params[:rate_type]
        error!({error: @user_rate.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_rate.save     
        #Device.notify User.find(params[:rate_id]).active_devices, { msg: "#{current_user.username} rate your profile.", who_like_photo: current_user.file.url, name: current_user.username, time: Time.now, id: current_user.id }
      end

      desc  "LIST Of NOTIFICATION"
      params  do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :list, jbuilder: 'android_notification' do
        @notifications = Rpush::Gcm::Notification.where(device_token: current_device.id).order(created_at: "desc").pluck
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
      post :listing, jbuilder: 'android_top' do
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
      post :send_questions, jbuilder: 'android_whiz_quiz' do
        @questions = Whizquiz.where(status: true).order("RANDOM()").limit(2)
      end

      desc 'Answer'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :question_ids
        requires :review_types
        optional :reviews
        optional :text_fields
      end
      post :answer_of_questions, jbuilder: 'android_whiz_quiz' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        params[:question_ids].count.times do |i|
        @user_whizquiz = UserWhizquiz.new user_id: params[:user_id], whizquiz_id: params[:question_ids][i] , review_type: params[:review_types][i] , status: false
            if (params[:review_types][i] == 'text')
                @user_whizquiz.text_field = params[:text_fields][i] if params[:text_fields][i]
            else
                @user_whizquiz.review = params[:reviews][i] if params[:reviews][i]
            end
        error!({error: @user_whizquiz.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_whizquiz.save
        end
      end
  end
  #--------------------------------whizquiz end----------------------------------#
  #--------------------------------search start----------------------------------#
  resources :search do
  before { authenticate! }

      desc 'Search Jobseeker'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :q
        optional :min_experience
        optional :max_experience
        optional :min_salary
        optional :max_salary
        optional :functional_area_id
        optional :location
        optional :preferred_location
        optional :qualification
      end
      post :jobseeker, jbuilder: 'android_search'  do
        authenticate!
        @searched_users =  User.includes("user_experiences").where("users.username ilike ?","%#{params[:q]}%").where("users.user_experiences.experience")
      end

      desc 'Search Company'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        optional :location
        optional :functional_area
        optional :industry_id
        optional :company_name
      end
      post :company, jbuilder: 'android_search'  do
        authenticate!
        @searched_company =  User.company_search(params)
      end

      desc 'Search Top User'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        optional :location
        optional :functional_area_id
        optional :industry_id
        optional :company_name
      end
      post :company, jbuilder: 'android_search'  do
        authenticate!
        @searched_company =  User.company_search(params)
      end

  end
  #--------------------------------search end----------------------------------#
  #--------------------------------marketiq start----------------------------------#
  resources :marketiq do
  before { authenticate! }

      desc 'Send random 10 question to Users'
      params do
        requires :token, type: String, regexp: UUID_REGEX
      end
      post :send_question, jbuilder: 'android_marketiq' do
          if current_user.role == 'Jobseeker'
              @marketiq = Marketiq.where(role: 'false').where(specialization_id: current_user.user_educations.pluck('specialization_id')).order("RANDOM()").first
          elsif current_user.role == 'Company'        
              @marketiq = Marketiq.where(role: 'true').where(industry_id: current_user.industry_id).order("RANDOM()").first
          end
          if @marketiq
              @user_marketiq = UserMarketiq.new user_id: current_user.id, marketiq_id: @marketiq.id
              error!({error: @user_marketiq.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_marketiq.save
          end
      end

      desc 'Send Answer Of Marketiq Question'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_marketiq_id
        requires :answer
      end
      post :send_answer, jbuilder: 'android_marketiq' do
        @answer_user_marketiq = UserMarketiq.find params[:user_marketiq_id]
        @answer_user_marketiq.answer = params[:answer]
        @answer_user_marketiq.status = true
        error!({error: @answer_user_marketiq.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @answer_user_marketiq.save
      end

      desc 'Users Market IQ List'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :list do
        @user = User.find params[:user_id]
        @user_marketiqs = @user.user_marketiqs
        @user_marketiqs
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
          if UserFolder.joins(:folder).where("user_folders.user_id = ?", current_user.id).where('folders.name = ?', params[:name]).count > 0
            error!({error: 'Folder name already exist! Please try another one!', status: 'Fail'}, 200)
          else
            @folder = Folder.new name: params[:name], default_status: false
            error!({error: @folder.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @folder.save
          end

          @user_folder = UserFolder.new user_id: current_user.id
          @user_folder.folder_id = @folder.id
          error!({error: @user_folder.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_folder.save
      end

      desc 'List Folder'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :listing, jbuilder: 'android_folder' do
          @user = User.find params[:user_id]
          error!({error: 'User not found', status: 'Fail'}, 200) unless @user
          @user_folders = @user.user_folders
          error!({error: @user_folders.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_folders
      end

      desc 'Edit folder'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :folder_id
        optional :name
      end
      post :edit, jbuilder: 'android_folder' do
        @folder = Folder.find params[:folder_id]
        error!({error: 'Folder not found', status: 'Fail'}, 200) unless @folder
        @folder.attributes = clean_params(params).permit(:name)
        error!({error: @folder.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @folder.save
      end

      desc 'Delete folder'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :folder_id
      end
      post :delete do
        @user_folder = UserFolder.where(user_id: current_user.id).where(folder_id: params[:folder_id]).first
        error!({error: 'Folder not found', status: 'Fail'}, 200) unless @user_folder
        if @user_folder.folder.default_status == false
        @user_folder.destroy
        { code: 200, status: 'Success'}
        else
          error!({error: 'You cant delete default folder', status: 'Fail'}, 200)
        end
      end  

      desc 'Delete folder user'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :delete_favourite_user do
        @user_fav = UserFavourite.where(user_id: current_user.id).where(favourite_id: params[:user_id]).first
        error!({error: 'Favourite User not found', status: 'Fail'}, 200) unless @user_fav
        @user_fav.destroy
        { code: 200, status: 'Success'}
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
        error!({error: 'Favourite User not found', status: 'Fail'}, 200) unless @user_fav
        @user_fav.folder_id = params[:new_folder_id]
        error!({error: @user_fav.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_fav.save
        { code: 200, status: 'Success'}
      end

      desc 'View folder'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :folder_id
      end
      post :view, jbuilder: 'android_folder' do
        @my_folder = UserFolder.find params[:folder_id]
        error!({error: 'Folder not found', status: 'Fail'}, 200) unless @my_folder
      end

  end
  #--------------------------------folder end----------------------------------#

end
