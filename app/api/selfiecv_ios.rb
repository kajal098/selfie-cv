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

  end

#--------------------------------devices start----------------------------------#

resources :devices do

  desc 'Register device after notification service subscription'
  params do
    requires :uuid, type: String, regexp: UUID_REGEX
    optional :registration_id, type: String
  end
  post :register do
    @device = Device.find_or_initialize_by uuid: params[:uuid]
    @device.registration_id = params[:registration_id]
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

    # for user registration
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
      @user_meter = UserMeter.new user_id: @user.id
      error! @user_meter.errors.full_messages.join(', '), 422 unless @user_meter.save
      
    end

    # for user login
    desc 'User login with email and password'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :username
      requires :password
      requires :role
    end
    post :login , jbuilder: 'ios' do
      @user = User.find_by username: params[:username]
      error! 'Device not registered',422 unless current_device
      error! 'User not found',422 unless @user
      error! 'authentication failed',422 unless @user.role == params[:role]
      error! 'Wrong username or password',422 unless @user.valid_password? params[:password]
      current_device.update_column :user_id, @user.id
    end

    # for send reset password token to reset password
    desc "Send reset password token"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :email
    end
    post :reset_code do
      if
        @user = User.find_by_email(params[:email])
        @user.update_column :reset_code, (SecureRandom.random_number*1000000).to_i
    #UserMailer.send_reset_code(@user).deliver_now
    @user.reset_code
    else
      error! "User does not exist.", 422
    end
    end

    # for resend reset password token to reset password
    desc "Resend reset password token"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :email
    end
    post :resend_reset_code do
      if
        @user = User.find_by_email(params[:email])
        @code = @user.reset_code
    #UserMailer.send_reset_code(@user).deliver_now
    @user.reset_code
    else
      error! "User does not exist.", 422
    end
    end

    # for reset password
    desc "Reset Password"
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

    # for change password
    desc "Change Password"
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
      @user
    end

    # for delete user account

    desc "Delete User Account"
    params do
      requires :token, type: String, regexp: UUID_REGEX
    end
    post :delete_account do
      authenticate!
      @user = current_user
      @user.destroy
      status 200
    end

    # for listing users
    desc "Listing Users"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :role
    end
    post :listing , jbuilder: 'ios' do
      if params[:role]
        @users = User.where(role: params[:role])
      else
        'No Records Found !'
      end
      @users
    end

    # for all stuff
    desc 'All stuff'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :all_stuff , jbuilder: 'android_all_stuff' do
      @user_stuff = User.find params[:user_id]
      error! 'User not found',422 unless @user_stuff      
    end

end
 
#--------------------------------member end----------------------------------#

#--------------------------------member profile start----------------------------------#
 
resources :member_profile do 

    # for fill user resume
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
      requires :contact_number
      optional :file
      optional :text_field
      optional :file_type
    end
    post :resume, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name,
       :last_name, :gender,  :date_of_birth, :nationality, :address, :city, :zipcode,
        :contact_number)
      if (params[:file_type] == 'text')
        @user.text_field = params[:text_field]
      else
        @user.file = params[:file] if params[:file]
      end
      error! @user.errors.full_messages.join(', '), 422 unless @user.save
      if(params[:file_type] == 'video')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 100
      elsif(params[:file_type] == 'audio')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 70
      elsif(params[:file_type] == 'file')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 50
      elsif(params[:file_type] == 'text')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 30
      end
      @user
    end

    # for update user resume
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
      optional :contact_number
      optional :file
      optional :text_field
      optional :file_type
    end
    post :update_resume, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error!({error: 'User not found', status: 'Fail'}, 200) unless @user
      @user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name,
       :last_name, :gender,  :date_of_birth, :nationality, :address, :city, :zipcode,
        :contact_number, :file_type)
      if (params[:file_type] == 'text')
        @user.text_field = params[:text_field]
      else
        @user.file = params[:file] if params[:file]
      end
      error! @user.errors.full_messages.join(', '), 422 unless @user.save
      if(params[:file_type] == 'video')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 100
      elsif(params[:file_type] == 'audio')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 70
      elsif(params[:file_type] == 'file')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 50
      elsif(params[:file_type] == 'text')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 30
      end
      @user
    end

    # for get user resume
    desc 'Get User Resume'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_user_resume, jbuilder: 'ios' do
      @user = User.find params[:user_id]
    end

    # for fill user's education
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
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_education = UserEducation.new user_id: @user.id
      if (params[:course_id] || params[:specialization_id] || params[:year] || params[:school] || params[:skill] )
        @user_education.attributes = clean_params(params).permit(:course_id, :specialization_id,  :year, :school, :skill)
        error! @user_education.errors.full_messages.join(', '), 422 unless @user_education.save
      end
    end

    # for update user's education
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
      @update_user_education = UserEducation.find params[:education_id]
      error! 'User Education not found',422 unless @update_user_education
      @update_user_education.attributes = clean_params(params).permit(:course_id, :specialization_id, :year,
        :school, :skill)
      error! @update_user_education.errors.full_messages.join(', '), 422 unless @update_user_education.save
      @update_user_education
    end

    # for get user's education detail
    desc 'Get Users Education Detail'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_educations, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_educations = @user.user_educations
    end

    #for delete education
    desc "Delete Education"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :education_id
    end
    post :delete_education do
      @education = UserEducation.find params[:education_id]
      @education.destroy
      status 200
    end

    # for fill user's experience
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
      optional :file
    end
    post :experience, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_experience = UserExperience.new user_id: @user.id
      @user_experience.attributes = clean_params(params).permit(:name, :start_from,  :working_till, :designation, :description, :exp_type)
      @user_experience.file = params[:file] if params[:file]
      error! @user_experience.errors.full_messages.join(', '), 422 unless @user_experience.save
    end

    # for update user's experience
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
      optional :file
    end
    post :update_experience, jbuilder: 'ios' do
      @update_user_experience = UserExperience.find params[:experience_id]
      error! 'User Experience not found',422 unless @update_user_experience
      @update_user_experience.attributes = clean_params(params).permit(:name, :start_from, :working_till,
        :designation, :description, :exp_type)
      @update_user_experience.file = params[:file] if params[:file]
      error! @update_user_experience.errors.full_messages.join(', '), 422 unless @update_user_experience.save
      @update_user_experience
    end

    # for get user's experience detail
    desc 'Get Users Experience Detail'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_experiences, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_experiences = @user.user_experiences
    end

    #for delete experience
    desc "Delete Experience"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :experience_id
    end
    post :delete_experience do
      @experience = UserExperience.find params[:experience_id]
      @experience.destroy
      status 200
    end

    # for fill user's preferred work details
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
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:ind_name] || params[:functional_name] || params[:preferred_designation] || params[:preferred_location] || params[:current_salary] || params[:expected_salary] || params[:time_type] )
        @user_preferred_work = UserPreferredWork.new user_id: @user.id
        @user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
        error! @user_preferred_work.errors.full_messages.join(', '), 422 unless @user_preferred_work.save
      end
    end

    # for update user's preferred work
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
      @update_user_preferred_work = UserPreferredWork.find params[:preferred_work_id]
      error! 'User not found',422 unless @update_user_preferred_work
      @update_user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
      error! @update_user_preferred_work.errors.full_messages.join(', '), 422 unless @update_user_preferred_work.save
      @update_user_preferred_work
    end

    # for get user's preferred works detail
    desc 'Get Users Preferred Work'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_preferred_works, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_preferred_works = @user.user_preferred_works
    end

    #for delete preffered work
    desc "Delete Preffered Work"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :preffered_work_id
    end
    post :delete_preffered_work do
      @preffered_work = UserPreferredWork.find params[:preffered_work_id]
      @preffered_work.destroy
      status 200
    end

    # for fill user awards
    desc 'User Award'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :award_type
      optional :name        
      optional :description        
      optional :file
    end
    post :award, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:award_type] || params[:name] || params[:descrption] )
        @award = UserAward.new user_id: @user.id
        @award.attributes = clean_params(params).permit(:name, :description)
        @award.award_type = params[:award_type] if params[:award_type]
        @award.file = params[:file] if params[:file]
        error! @award.errors.full_messages.join(', '), 422 unless @award.save
      end
    end

    # for update user's award
    desc 'Update User Award'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :award_id
      optional :award_type
      optional :name        
      optional :description        
      optional :file
    end
    post :update_award, jbuilder: 'ios' do
      @update_user_award = UserAward.find params[:award_id]
      error! 'User not found',422 unless @update_user_award
      @update_user_award.attributes = clean_params(params).permit(:name, :description)
      @update_user_award.file = params[:file] if params[:file]
      error! @update_user_award.errors.full_messages.join(', '), 422 unless @update_user_award.save
      @update_user_award
    end

    # for get user's awards
    desc 'Get Users Award'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_award, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_awards = @user.user_awards
    end

    #for delete award
    desc "Delete Award"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :award_id
    end
    post :delete_award do
      @award = UserAward.find params[:award_id]
      @award.destroy
      status 200
    end

    # for fill user certificates
    desc 'User Certificate'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :name
      optional :year
      optional :certificate_type        
      optional :file
    end
    post :certificate, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:name] || params[:year] || params[:certificate_type] )
        @certificate = UserCertificate.new user_id: @user.id
        @certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type)
        @certificate.file = params[:file] if params[:file]
        error! @certificate.errors.full_messages.join(', '), 422 unless @certificate.save
      end
    end

    # for update user's certificates
    desc 'Update User Certificate'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :certificate_id
      optional :name
      optional :year
      optional :certificate_type        
      optional :file
    end
    post :update_certificate, jbuilder: 'ios' do
      @update_user_certificate = UserCertificate.find params[:certificate_id]
      error! 'User Certificate not found',422 unless @update_user_certificate
      @update_user_certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type)
      @certificate.file = params[:file] if params[:file]
      error! @update_user_certificate.errors.full_messages.join(', '), 422 unless @update_user_certificate.save
      @update_user_certificate
    end

    # for get user's certificate
    desc 'Get Users Certificate Detail'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_certificates, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_certificates = @user.user_certificates
    end

    #for delete certificate
    desc "Delete Certificate"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :certificate_id
    end
    post :delete_certificate do
      @certificate = UserCertificate.find params[:certificate_id]
      @certificate.destroy
      status 200
    end

    # for fill curriculars
    desc 'User Curriculars'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :curricular_type
      optional :title
      optional :team_type        
      optional :location
      optional :date
      optional :file
    end
    post :curriculars, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:curricular_type] || params[:title] || params[:team_type] || params[:location] || params[:date] )
        @curricular = UserCurricular.new user_id: @user.id
        @curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date)
        @curricular.file = params[:file] if params[:file]
        error! @curricular.errors.full_messages.join(', '), 422 unless @curricular.save 
      end         
    end

    # for update user's curriculars
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
    end
    post :update_curricular, jbuilder: 'ios' do
      @update_user_curricular = UserCurricular.find params[:curricular_id]
      error! 'User Curricular not found',422 unless @update_user_curricular
      @update_user_curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date)
      @update_user_curricular.file = params[:file] if params[:file]
      error! @update_user_curricular.errors.full_messages.join(', '), 422 unless @update_user_curricular.save
      @update_user_curricular
    end

    # for get user's curriculars detail
    desc 'Get Users Curriculars Detail'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_curriculars, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_curriculars = @user.user_curriculars
    end

    #for delete curricular
    desc "Delete Curricular"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :curricular_id
    end
    post :delete_curricular do
      @curricular = UserCurricular.find params[:curricular_id]
      @curricular.destroy
      status 200
    end

    # for fill future goal
    desc 'User Future Goal'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :goal_type
      optional :title
      optional :term_type        
      optional :file
    end
    post :future_goal, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:goal_type] || params[:title] || params[:term_type] )
        @future_goal = UserFutureGoal.new user_id: @user.id, goal_type: params[:goal_type], title: params[:title],term_type: params[:term_type]
        @future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type)
        @future_goal.file = params[:file] if params[:file]
        error! @future_goal.errors.full_messages.join(', '), 422 unless @future_goal.save
      end          
    end

    # for update user's future goal
    desc 'Update User Future Goal'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :future_goal_id
      optional :goal_type
      optional :title
      optional :term_type        
      optional :file
    end
    post :update_future_goal, jbuilder: 'ios' do
      @update_user_future_goal = UserFutureGoal.find params[:future_goal_id]
      error! 'User Future Goal not found',422 unless @update_user_future_goal
      @update_user_future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type)
      @update_user_future_goal.file = params[:file] if params[:file]
      error! @update_user_future_goal.errors.full_messages.join(', '), 422 unless @update_user_future_goal.save
      @update_user_future_goal
    end

    # for get user's future goals detail
    desc 'Get Users Future Goals Detail'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_future_goals, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_future_goals = @user.user_future_goals
    end

    #for delete future goal
    desc "Delete Future Goal"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :future_goal_id
    end
    post :delete_future_goal do
      @future_goal = UserFutureGoal.find params[:future_goal_id]
      @future_goal.destroy
      status 200
    end

    # for fill working environment
    desc 'User Working Environment'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :env_type
      optional :title
      optional :file
    end
    post :working_environment, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:env_type] || params[:title] )
        @environment = UserEnvironment.new user_id: @user.id
        @environment.attributes = clean_params(params).permit(:env_type, :title)
        @environment.file = params[:file] if params[:file]
        error! @environment.errors.full_messages.join(', '), 422 unless @environment.save
      end          
    end

    # for update user's working environment
    desc 'Update User Working Environment'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :environment_id
      optional :env_type
      optional :title
      optional :file
    end
    post :update_working_environment, jbuilder: 'ios' do
      @update_user_environment = UserEnvironment.find params[:environment_id]
      error! 'User Environment not found',422 unless @update_user_environment
      @update_user_environment.attributes = clean_params(params).permit(:env_type, :title)
      @update_user_environment.file = params[:file] if params[:file]
      error! @update_user_environment.errors.full_messages.join(', '), 422 unless @update_user_environment.save
      @update_user_environment
    end

    # for get user's working environments detail
    desc 'Get Users Working Environments Detail'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_working_environments, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_working_environments = @user.user_environments
    end

    #for delete work environment
    desc "Delete Work Environment"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :work_env_id
    end
    post :delete_work_env do
      @work_env = UserEnvironment.find params[:work_env_id]
      @work_env.destroy
      status 200
    end

    # for fill references
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
    end
    post :references, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @reference = UserReference.new user_id: @user.id
      if (params[:title] || params[:ref_type] || params[:from] || params[:email] || params[:contact] || params[:date] || params[:location] )
        @reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location)
        @reference.file = params[:file] if params[:file]
        error! @reference.errors.full_messages.join(', '), 422 unless @reference.save
      end          
    end

    # for update user's references
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
    end
    post :update_references, jbuilder: 'ios' do
      @update_user_reference = UserReference.find params[:reference_id]
      error! 'User not found',422 unless @update_user_reference
      @update_user_reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location)
      @update_user_reference.file = params[:file] if params[:file]
      error! @update_user_reference.errors.full_messages.join(', '), 422 unless @update_user_reference.save
      @update_user_reference
    end

    # for get user's references detail
    desc 'Get Users References Detail'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_references, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user_references = @user.user_references
    end
    
    #for delete reference
    desc "Delete reference"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :reference_id
    end
    post :delete_reference do
      @reference = UserReference.find params[:reference_id]
      @reference.destroy
      status 200
    end

end

#--------------------------------member profile end----------------------------------#

#--------------------------------company start----------------------------------#

resources :company do 

    # for fill company information
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
      requires :company_country
      requires :company_contact
      optional :company_skype_id
      requires :company_id
    end
    post :company_info, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if @user.role == 'Company'
        @user.attributes = clean_params(params).permit(:company_name, :company_establish_from, :industry_id, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country, :company_contact, :company_skype_id, :company_id)
        error! @user.errors.full_messages.join(', '), 422 unless @user.save
      else
        error! "Record not found.", 422
      end
    end
    # for corporate identity
    desc 'Corporate Identity'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :company_logo
      optional :company_profile
      optional :company_brochure        
      optional :company_website
      optional :company_facebook_link
    end
    post :corporate_identity, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if @user.role == 'Company'
        @user.attributes = clean_params(params).permit(:company_website, :company_facebook_link)
        error! @user.errors.full_messages.join(', '), 422 unless @user.save
        @user.company_logo = params[:company_logo] if params[:company_logo]
        @user.company_profile = params[:company_profile] if params[:company_profile]
        @user.company_brochure = params[:company_brochure] if params[:company_brochure]
      else
        error! "Record not found.", 422
      end
    end

    # for evalution information
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

    # for get evalution information
    desc 'Get Company Evalution Information'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_company_information, jbuilder: 'ios' do
      @company = User.find params[:user_id]
      error! 'User not found', 422 unless @company
    end

    # for company future goal
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

    #edit company info
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
      optional :company_country
      optional :company_contact
      optional :company_skype_id
      optional :company_id
      optional :company_logo
      optional :company_profile
      optional :company_brochure        
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
      @company = User.find params[:user_id]
      
      @company.attributes = clean_params(params).permit(:company_name, :company_establish_from, :industry_id, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country, :company_contact, :company_skype_id, :company_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet)
      @user.company_logo = params[:company_logo] if params[:company_logo]
        @user.company_profile = params[:company_profile] if params[:company_profile]
        @user.company_brochure = params[:company_brochure] if params[:company_brochure]
      error! @company.errors.full_messages.join(', '), 422 unless @company.save
    end

    # for company galery
    desc 'Company Galery'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      requires :files, type: Array, default: []
    end
    post :company_galery, jbuilder: 'galery' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      params[:files].each do |file|
        @galleries = CompanyGalery.new user_id: params[:user_id]
        @galleries.file = file
        error! @galleries.errors.full_messages.join(', '), 422 unless @galleries.save
      end
      {}
    end

end

#--------------------------------company end----------------------------------#

#--------------------------------data start----------------------------------#

resources :data do 

    # for dropdown data
    desc 'Company Information'
    params do
      requires :token, type: String, regexp: UUID_REGEX
    end
    post :all_data, jbuilder: 'ios' do
      @courses = Course.all
      @specializations = Specialization.all
      @companies = Company.all
      @industries = Industry.all
    end

    # for update student education
    desc 'Update Student Education'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :profile_pic
    end
    post :update_image, jbuilder: 'ios' do
      @update_image = User.find params[:user_id]
      error! 'User Environment not found',422 unless @update_image
      @update_image.profile_pic = params[:profile_pic] if params[:profile_pic]
      error! @update_image.errors.full_messages.join(', '), 422 unless @update_image.save
      @update_image
    end
  

end

#--------------------------------data end----------------------------------#

#--------------------------------student start----------------------------------#

resources :student do 

    # for fill student basic info
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
      optional :contact_number
      optional :file
      optional :file_type
    end
    post :basic_info, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error!({error: 'User not found', status: 'Fail'}, 200) unless @user
      @user.attributes = clean_params(params).permit(:first_name,  :last_name, :gender,  :date_of_birth, :nationality, :address, :city, :zipcode,  :contact_number, :file_type)
      @user.file = params[:file] if params[:file]
      error! @user.errors.full_messages.join(', '), 422 unless @user.save
      @user
    end

    # for update user's education
    desc 'Update User Education'
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
      optional :contact_number
      optional :file
      optional :file_type
    end
    post :update_basic_info, jbuilder: 'ios' do
      @basic_info = User.find params[:user_id]
      error! 'User not found', 422 unless @basic_info
      @basic_info.attributes = clean_params(params).permit(:first_name, :last_name, :gender,
        :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :file_type)
      error! @basic_info.errors.full_messages.join(', '), 422 unless @basic_info.save
      @basic_info
    end

    # for get basic info
    desc 'Get Basic Info'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_basic_info, jbuilder: 'ios' do
      @basic_info = User.find params[:user_id]
      error! 'User not found', 422 unless @basic_info
    end

    # for fill student education
    desc 'Student Education'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :standard
      optional :school
      optional :year
    end
    post :student_education, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:standard] || params[:school] || params[:year] )
        @student_education = StudentEducation.new user_id: @user.id
        @student_education.attributes = clean_params(params).permit(:standard, :school, :year)
        error! @student_education.errors.full_messages.join(', '), 422 unless @student_education.save
      end          
    end

    # for update student education
    desc 'Update Student Education'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :education_id
      optional :standard
      optional :school
      optional :year
    end
    post :update_student_education, jbuilder: 'ios' do
      @update_student_education = StudentEducation.find params[:education_id]
      error! 'User Environment not found',422 unless @update_student_education
      @update_student_education.attributes = clean_params(params).permit(:standard, :school, :year)
      @update_student_education.file = params[:file] if params[:file]
      error! @update_student_education.errors.full_messages.join(', '), 422 unless @update_student_education.save
      @update_student_education
    end

    #for delete student education
    desc "Delete Student Education"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :education_id
    end
    post :delete_student_education do
      @student_education = StudentEducation.find params[:education_id]
      @student_education.destroy
      status 200
    end

    # for fill student marksheet
    desc 'Student Marksheet'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :school_name
      optional :standard
      optional :grade
      optional :year
      optional :file
      optional :file_type
    end
    post :student_marksheet, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:school_name] || params[:standard] || params[:grade] || params[:year] )
        @student_marksheet = UserMarksheet.new user_id: @user.id
        @student_marksheet.attributes = clean_params(params).permit(:school_name, :standard, :grade, :year)
        @student_marksheet.file = params[:file] if params[:file]
        error! @student_marksheet.errors.full_messages.join(', '),422 unless @student_marksheet.save
      end          
    end

    # for update student education
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
      @update_student_marksheet = UserMarksheet.find params[:marksheet_id]
      error! 'Student marksheet not found',422 unless @update_student_marksheet
      @update_student_marksheet.attributes = clean_params(params).permit(:school_name, :standard, :grade, :year)
      @update_student_marksheet.file = params[:file] if params[:file]
      error! @update_student_marksheet.errors.full_messages.join(', '),422 unless @update_student_marksheet.save
      @update_student_marksheet
    end

    #for delete student marksheet
    desc "Delete Student Marksheet"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :marksheet_id
    end
    post :delete_student_marksheet do
      @student_education = UserMarksheet.find params[:marksheet_id]
      @student_education.destroy
      status 200
    end

    # for fill student project
    desc 'Student Project'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :title
      optional :description
    end
    post :student_project, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:title] || params[:description] )
        @student_project = UserProject.new user_id: @user.id
        @student_project.attributes = clean_params(params).permit(:title, :description)
        error! @student_project.errors.full_messages.join(', '),422 unless @student_project.save
      end          
    end

    # for update student project
    desc 'Update Student Project'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :project_id
      optional :title
      optional :description
    end
    post :update_student_project, jbuilder: 'ios' do
      @update_student_project = UserProject.find params[:project_id]
      error! 'Student project not found',422 unless @update_student_project
      @update_student_project.attributes = clean_params(params).permit(:title, :description)
      @update_student_project.file = params[:file] if params[:file]
      error! @update_student_project.errors.full_messages.join(', '),422 unless @update_student_project.save
      @update_student_project
    end

    #for delete student project
    desc "Delete Student Project"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :project_id
    end
    post :delete_student_project do
      @student_project = UserProject.find params[:project_id]
      @student_project.destroy
      status 200
    end

    # for get student stuff
    desc 'Get Student Stuff'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_student_stuff, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @student_educations = @user.student_educations
      @student_marksheets = @user.user_marksheets
      @student_projects = @user.user_projects
    end

end

#--------------------------------student end----------------------------------#

#--------------------------------faculty start----------------------------------#

resources :faculty do 

# for fill faculty resume
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
      optional :country
      optional :zipcode
      optional :contact_number
      optional :file
      optional :text_field
      optional :file_type
    end
    post :basic_info, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @user.attributes = clean_params(params).permit(:first_name,  :middle_name, :last_name, :gender,
        :date_of_birth, :nationality, :address, :city, :country, :zipcode,  :contact_number, :file_type)
      if (params[:file_type] == 'text')
        @user.text_field = params[:text_field]
      else
        @user.file = params[:file] if params[:file]
      end
      error! @user.errors.full_messages.join(', '),422 unless @user.save
      if(params[:file_type] == 'video')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 100
      elsif(params[:file_type] == 'audio')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 70
      elsif(params[:file_type] == 'file')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 50
      elsif(params[:file_type] == 'text')
        @user_meter = UserMeter.find_by user_id: params[:user_id]
        @user_meter.update_column :resume_per, 30
      end
      @user
    end

    # for fill faculty affiliation
    desc 'Faculty Affiliation'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :university
      optional :collage_name
      optional :subject
      optional :designation
      optional :join_from
    end
    post :faculty_affiliation, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:collage_name] || params[:subject] || params[:designation] || params[:join_from] )
        @faculty_affiliation = FacultyAffiliation.new user_id: @user.id
        @faculty_affiliation.attributes = clean_params(params).permit(:university, :collage_name, :subject, :designation, :join_from)
        error! @faculty_affiliation.errors.full_messages.join(', '),422 unless @faculty_affiliation.save
      end          
    end

    # for update faculty affiliation
    desc 'Update Faculty Affiliation'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :affiliation_id
      optional :university
      optional :collage_name
      optional :subject
      optional :designation
      optional :join_from
    end
    post :update_faculty_affiliation, jbuilder: 'ios' do
      @update_faculty_affiliation = FacultyAffiliation.find params[:affiliation_id]
      error! 'Faculty affiliation not found',422 unless @update_faculty_affiliation
      @update_faculty_affiliation.attributes = clean_params(params).permit(:university, :collage_name, :subject, :designation, :join_from)
      error! @update_faculty_affiliation.errors.full_messages.join(', '),422 unless @update_faculty_affiliation.save
      @update_faculty_affiliation
    end

    #for delete faculty affiliation
    desc "Delete Faculty Affiliation"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :affiliation_id
    end
    post :delete_faculty_affiliation do
      @faculty_affiliation = FacultyAffiliation.find params[:affiliation_id]
      @faculty_affiliation.destroy
      status 200
    end

    # for fill faculty workshop
    desc 'Faculty Workshop'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :description
    end
    post :faculty_workshop, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      
        @faculty_workshop = FacultyWorkshop.new user_id: @user.id
        @faculty_workshop.attributes = clean_params(params).permit(:description)
        error!({error: @faculty_workshop.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @faculty_workshop.save
           
    end

    # for update faculty workshop
    desc 'Update Faculty Workshop'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :workshop_id
      optional :description
    end
    post :update_faculty_workshop, jbuilder: 'ios' do
      @update_faculty_workshop = FacultyWorkshop.find params[:workshop_id]
      error! 'Student workshop not found',422 unless @update_faculty_workshop
      @update_faculty_workshop.attributes = clean_params(params).permit(:description)
      error! @update_faculty_workshop.errors.full_messages.join(', '),422 unless @update_faculty_workshop.save
      @update_faculty_workshop
    end

    #for delete faculty workshop
    desc 'Delete Faculty Workshop'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :workshop_id
    end
    post :delete_faculty_workshop do
      @faculty_workshop = FacultyWorkshop.find params[:workshop_id]
      @faculty_workshop.destroy
      status 200
    end

    # for fill faculty publication
    desc 'Faculty Publication'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :title
      optional :description
    end
    post :faculty_publication, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:title] || params[:description] )
        @faculty_publication = FacultyPublication.new user_id: @user.id
        @faculty_publication.attributes = clean_params(params).permit(:title, :description)
        error! @faculty_publication.errors.full_messages.join(', '),422 unless @faculty_publication.save
      end          
    end

    # for update faculty publication
    desc 'Update Faculty Publication'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :publication_id
      optional :title
      optional :description
    end
    post :update_faculty_publication, jbuilder: 'ios' do
      @update_faculty_publication = FacultyPublication.find params[:publication_id]
      error! 'Student publication not found',422 unless @update_faculty_publication
      @update_faculty_publication.attributes = clean_params(params).permit(:title, :description)
      error! @update_faculty_publication.errors.full_messages.join(', '),422 unless @update_faculty_publication.save
      @update_faculty_publication
    end

    #for delete faculty publication
    desc "Delete Faculty Publication"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :publication_id
    end
    post :delete_faculty_publication do
      @faculty_publication = FacultyPublication.find params[:publication_id]
      @faculty_publication.destroy
      status 200
    end

    # for fill faculty research
    desc 'Faculty Research'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
      optional :title
      optional :description
    end
    post :faculty_research, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      if (params[:title] || params[:description] )
        @faculty_research = FacultyResearch.new user_id: @user.id
        @faculty_research.attributes = clean_params(params).permit(:title, :description)
        error! @faculty_research.errors.full_messages.join(', '),422 unless @faculty_research.save
      end          
    end

    # for update faculty research
    desc 'Update Faculty Reaserch'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :research_id
      optional :title
      optional :description
    end
    post :update_faculty_research, jbuilder: 'ios' do
      @update_faculty_research = FacultyResearch.find params[:research_id]
      error! 'Student research not found',422 unless @update_faculty_research
      @update_faculty_research.attributes = clean_params(params).permit(:title, :description)
      error! @update_faculty_research.errors.full_messages.join(', '),422 unless @update_faculty_research.save
      @update_faculty_research
    end

    #for delete faculty research
    desc "Delete Faculty Research"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :research_id
    end
    post :delete_faculty_research do
      @faculty_research = FacultyResearch.find params[:research_id]
      @faculty_research.destroy
      status 200
    end

    # for get faculty stuff
    desc 'Get Faculty Stuff'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :user_id
    end
    post :get_faculty_stuff, jbuilder: 'ios' do
      @user = User.find params[:user_id]
      error! 'User not found',422 unless @user
      @faculty_affiliations = @user.faculty_affiliations
      @faculty_workshops = @user.faculty_workshops
      @faculty_publications = @user.faculty_publications
      @faculty_researches = @user.faculty_researches
    end

end

#--------------------------------faculty end----------------------------------#

#--------------------------------group start----------------------------------#

resources :group do 

    # for create group
    params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :name
        optional :group_pic
    end

    post :create, jbuilder: 'ios_group' do
        @group = Group.new clean_params(params).permit(:name)
        @group.code = Random.rand(500000..900000)
        @group.group_pic = params[:group_pic]
        error! @group.errors.full_messages.join(', '), 422 unless @group.save
        @group_user = GroupUser.new user_id: current_user.id, group_id: @group.id, admin: true , status: 'joined' 
        error! @group_user.errors.full_messages.join(', '), 422 unless @group_user.save
        #Device.notify User.where(id: current_user.id).active_devices, alert: "#{current_user} has added you to group #{@group}."
    end

    # for listing groups of current user
    params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
    end

    post :listing, jbuilder: 'ios_group' do
        @groups = current_user.all_groups
    end

    # for view of group

    desc "Information of Group"

    params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
    end

    post :info, jbuilder: 'ios_group' do
        @group = Group.find(params[:group_id])
        error! 'Record not found',422 unless @group
    end

    # for update group detail

    desc "Update Group"

    params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
        optional :name
        optional :group_pic
    end

    post :update, jbuilder: 'android_group' do
        @group = Group.find params[:group_id]
        @group.attributes = clean_params(params).permit(:name)
        @group.group_pic = params[:group_pic] if params[:group_pic]
        error! @group.errors.full_messages.join(', '), 422 unless @group.save
        @group
    end

    #for delete group

    desc "Delete Group"

    params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :group_id
    end

    post :delete do
        @group = Group.find params[:group_id]
        @group.destroy
        status 200
    end

    # Join group

    desc 'Join Group'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :code
    end

    post :join, jbuilder: 'ios_group' do
      @group = Group.find_by_code params[:code]
      error! 'Group not found or wrong code', 422 unless @group
      @group_user = GroupUser.new user_id: current_user.id, group_id: @group.id , admin: false , status: 'joined' 
      error! @group_user.errors.full_messages.join(', '),422 unless @group_user.save     
      @group_user
    end

    # leave group

    desc 'Leave Group'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :group_id
    end

    post :leave, jbuilder: 'ios_group' do
        @group = Group.find params[:group_id]
        @group_user = @group.users.where(user_id: current_user.id).first
        @group_user.status = "leaved"
        @group_user.save
    end

end

#--------------------------------group end----------------------------------#


end
