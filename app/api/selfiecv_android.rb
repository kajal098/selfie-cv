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

# devices start

  resources :devices do

    desc 'Register device after notification service subscription'
    params do
      requires :uuid, type: String, regexp: UUID_REGEX
      requires :registration_id, type: String
    end
    post :register do
      @device = Device.find_or_initialize_by uuid: params[:uuid]
      @device.registration_id = params[:registration_id]
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

  # devices end

  # member start

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
      post :register, jbuilder: 'android' do
        @user = User.new clean_params(params).permit(:username, :email, :password, :password_confirmation, :role)
        error!({error: 'Device not registered', status: 'Fail'}, 200) unless current_device
        error!({error: 'password not matched', status: 'Fail'}, 200) if params[:password] != params[:password_confirmation]
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
        @user_meter = UserMeter.new user_id: @user.id
        error!({error: @user_meter.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_meter.save
      end

    # for user login

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
      error!({error: 'Authentication failed', status: 'Fail'}, 200) unless @user.role == params[:role]
      error!({error: 'Wrong username or password', status: 'Fail'}, 200) unless @user.valid_password? params[:password]
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
      { code: @user.reset_code, :status => "Success" }
    else
      error!({error: 'User does not exist', status: 'Fail'}, 200)
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
      error!({error: 'Wrong reset code.', status: 'Fail'}, 200) unless @user
      error!({error: 'Password not same as previous password.', status: 'Fail'}, 200) if @user.valid_password?(params[:password])
      error!({error: 'password not matched', status: 'Fail'}, 200) if params[:password] != params[:password_confirmation]
      @user.attributes = clean_params(params).permit(:password, :password_confirmation)
      error! @user.errors.full_messages.join(', '), 200 unless @user.save
      { msg: 'Your password has been changed ..!!', :status => "Success" }
    end

    # for change password

    desc "Change Password"
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
      error! @user.errors.full_messages.join(', '), 200 unless @user.save
      @user
    end

    # for listing users

    desc "Listing Users"
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :role
      end
      post :listing , jbuilder: 'android' do
          @users = User.where(role: params[:role])
        @users         
      end

  

    # for fill user resume

    desc 'User Resume'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :title
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
        optional :file_type
      end
      post :resume, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name, :last_name, :gender,  :date_of_birth, :nationality, :address, :city,  :contact_number)
        @user.file = params[:file] if params[:file]
        error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
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
      post :education, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_education = UserEducation.new user_id: @user.id
        if (params[:course_id] || params[:specialization_id] || params[:year] || params[:school] || params[:skill] )
          @user_education.attributes = clean_params(params).permit(:course_id, :specialization_id,  :year, :school, :skill)
          @user.file = params[:file] if params[:file]
          error!({error: @user_education.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_education.save
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
      post :update_education, jbuilder: 'update_android' do
        @user_education = UserEducation.find params[:education_id]
        error!({error: 'User Education not found', status: 'Fail'}, 200) unless @user_education
        @user_education.attributes = clean_params(params).permit(:course_id, :specialization_id, :year,
          :school, :skill)
        error!({error: @user_education.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_education.save
        @user_education
      end

    # for get user's education detail

    desc 'Get Users Education Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_educations, jbuilder: 'listing_android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_educations = @user.user_educations
      end

      #for delete education

      desc "Delete Education"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :education_id
      end

      get :delete_education do
        @education = UserEducation.find params[:education_id]
        @education.destroy
        { code: 200, :status => "Success" }
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
        optional :file
      end
      post :experiences, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_experience = UserExperience.new user_id: @user.id
        @user_experience.attributes = clean_params(params).permit(:name, :start_from,  :working_till, :designation)
        @user_experience.file = params[:file] if params[:file]
        error!({error: @user_experience.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_experience.save
      end

      # for update user's experience

    desc 'Update User Experience'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :experience_id
        optional :name
        optional :start_from
        optional :working_till
        optional :designation
        optional :file
      end
      post :update_experience, jbuilder: 'update_android' do
        @user_experience = UserExperience.find params[:experience_id]
        error!({error: 'User Experience not found', status: 'Fail'}, 200) unless @user_experience
        @user_experience.attributes = clean_params(params).permit(:name, :start_from, :working_till,
          :designation)
        @user_experience.file = params[:file] if params[:file]
        error!({error: @user_experience.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_experience.save
        @user_experience
      end

    # for get user's experience detail

    desc 'Get Users Experience Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_experiences, jbuilder: 'listing_android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_experiences = @user.user_experiences
      end

      #for delete experience

      desc "Delete Experience"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :experience_id
      end

      get :delete_experience do
        @experience = UserExperience.find params[:experience_id]
        @experience.destroy
        { code: 200, :status => "Success" }
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
      post :preferred_work, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        if (params[:ind_name] || params[:functional_name] || params[:preferred_designation] || params[:preferred_location] || params[:current_salary] || params[:expected_salary] || params[:time_type] )
          @user_preferred_work = UserPreferredWork.new user_id: @user.id
          @user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
          error!({error: @user_preferred_work.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_preferred_work.save
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
      post :update_preferred_work, jbuilder: 'update_android' do
        @user_preferred_work = UserPreferredWork.find params[:preferred_work_id]
        error!({error: 'User Preffered Work not found', status: 'Fail'}, 200) unless @user_preferred_work
        @user_preferred_work.attributes = clean_params(params).permit(:ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type)
        error!({error: @user_preferred_work.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_preferred_work.save
        @user_preferred_work
      end

    # for get user's preferred works detail

    desc 'Get Users Preferred Work'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_preferred_works, jbuilder: 'listing_android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_preferred_works = @user.user_preferred_works
      end

      #for delete preffered work

      desc "Delete Preffered Work"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :preffered_work_id
      end

      get :delete_preffered_work do
        @preffered_work = UserPreferredWork.find params[:preffered_work_id]
        @preffered_work.destroy
        { code: 200, :status => "Success" }
      end

    # for fill user awards

    desc 'User Award'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        optional :name        
        optional :description        
        optional :file
      end
        post :award, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
            if (params[:name] || params[:descrption] )
                    @award = UserAward.new user_id: @user.id
                    @award.attributes = clean_params(params).permit(:name, :description)
                    @award.file = params[:file] if params[:file]
                    error!({error: @award.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @award.save
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
      post :update_award, jbuilder: 'update_android' do
        @user_award = UserAward.find params[:award_id]
        error!({error: 'User Award not found', status: 'Fail'}, 200) unless @user_award
        @user_award.attributes = clean_params(params).permit(:name, :description)
        @user_award.file = params[:file] if params[:file]
        error!({error: @user_award.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_award.save
        @user_award
      end

      # for get user's awards

      desc 'Get Users Award'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_award, jbuilder: 'listing_android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_awards = @user.user_awards
      end

      #for delete award

      desc "Delete Award"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :award_id
      end

      get :delete_award do
        @award = UserAward.find params[:award_id]
        @award.destroy
        { code: 200, :status => "Success" }
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
        post :certificate, jbuilder: 'android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
            if (params[:name] || params[:year] || params[:certificate_type] )
                    @certificate = UserCertificate.new user_id: @user.id
                    @certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type)
                    @certificate.file = params[:file] if params[:file]
                    error!({error: @certificate.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @certificate.save
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
      post :update_certificate, jbuilder: 'update_android' do
        @user_certificate = UserCertificate.find params[:certificate_id]
        error!({error: 'User Certificate not found', status: 'Fail'}, 200) unless @user_certificate
        @user_certificate.attributes = clean_params(params).permit(:name, :year, :certificate_type)
        @certificate.file = params[:file] if params[:file]
        error!({error: @user_certificate.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_certificate.save
        @user_certificate
      end

      # for get user's certificate

      desc 'Get Users Certificate Detail'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
      end
      post :get_certificates, jbuilder: 'listing_android' do
        @user = User.find params[:user_id]
        error!({error: 'User not found', status: 'Fail'}, 200) unless @user
        @user_certificates = @user.user_certificates
      end

      #for delete certificate

      desc "Delete Certificate"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :certificate_id
      end

      get :delete_certificate do
        @certificate = UserCertificate.find params[:certificate_id]
        @certificate.destroy
        { code: 200, :status => "Success" }
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
        post :curriculars, jbuilder: 'android' do
          @user = User.find params[:user_id]
          error!({error: 'User not found', status: 'Fail'}, 200) unless @user
          if (params[:curricular_type] || params[:title] || params[:team_type] || params[:location] || params[:date] )
            @curricular = UserCurricular.new user_id: @user.id
            @curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date)
            @curricular.file = params[:file] if params[:file]
            error!({error: @curricular.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @curricular.save
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
        post :update_curricular, jbuilder: 'update_android' do
          @user_curricular = UserCurricular.find params[:curricular_id]
          error!({error: 'User Curricular not found', status: 'Fail'}, 200) unless @user_curricular
          @user_curricular.attributes = clean_params(params).permit(:curricular_type,:title,:team_type,:location, :date)
          @user_curricular.file = params[:file] if params[:file]
          error!({error: @user_curricular.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user_curricular.save
          @user_curricular
        end

        # for get user's curriculars detail

        desc 'Get Users Curriculars Detail'
        params do
          requires :token, type: String, regexp: UUID_REGEX
          requires :user_id
        end
        post :get_curriculars, jbuilder: 'listing_android' do
          @user = User.find params[:user_id]
          error!({error: 'User not found', status: 'Fail'}, 200) unless @user
          @user_curriculars = @user.user_curriculars
        end

        #for delete curricular

      desc "Delete Curricular"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :curricular_id
      end

      get :delete_curricular do
        @curricular = UserCurricular.find params[:curricular_id]
        @curricular.destroy
        { code: 200, :status => "Success" }
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
          post :future_goal, jbuilder: 'android' do
            @user = User.find params[:user_id]
            error!({error: 'User not found', status: 'Fail'}, 200) unless @user
            if (params[:goal_type] || params[:title] || params[:term_type] )
              @future_goal = UserFutureGoal.new user_id: @user.id
              @future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type)
              @future_goal.file = params[:file] if params[:file]
              error!({error: @future_goal.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @future_goal.save
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
        post :update_future_goal, jbuilder: 'update_android' do
          @future_goal = UserFutureGoal.find params[:future_goal_id]
          error!({error: 'User Future Goal not found', status: 'Fail'}, 200) unless @future_goal
          @future_goal.attributes = clean_params(params).permit(:goal_type,:title,:term_type)
          @future_goal.file = params[:file] if params[:file]
          error!({error: @future_goal.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @future_goal.save
          @future_goal
        end

        # for get user's future goals detail

        desc 'Get Users Future Goals Detail'
        params do
          requires :token, type: String, regexp: UUID_REGEX
          requires :user_id
        end
        post :get_future_goals, jbuilder: 'listing_android' do
          @user = User.find params[:user_id]
          error!({error: 'User not found', status: 'Fail'}, 200) unless @user
          @user_future_goals = @user.user_future_goals
        end

        #for delete future goal

      desc "Delete Future Goal"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :future_goal_id
      end

      get :delete_future_goal do
        @future_goal = UserFutureGoal.find params[:future_goal_id]
        @future_goal.destroy
        { code: 200, :status => "Success" }
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
            post :working_environment, jbuilder: 'android' do
              @user = User.find params[:user_id]
              error!({error: 'User not found', status: 'Fail'}, 200) unless @user
              if (params[:env_type] || params[:title] )
                @environment = UserEnvironment.new user_id: @user.id
                @environment.attributes = clean_params(params).permit(:env_type, :title)
                @environment.file = params[:file] if params[:file]
                error!({error: @environment.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @environment.save
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
        post :update_working_environment, jbuilder: 'update_android' do
          @environment = UserEnvironment.find params[:environment_id]
          error!({error: 'User Environment not found', status: 'Fail'}, 200) unless @environment
          @environment.attributes = clean_params(params).permit(:env_type, :title)
          @environment.file = params[:file] if params[:file]
          error!({error: @environment.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @environment.save
          @environment
        end

          # for get user's working environments detail

          desc 'Get Users Working Environments Detail'
          params do
            requires :token, type: String, regexp: UUID_REGEX
            requires :user_id
          end
          post :get_working_environments, jbuilder: 'listing_android' do
            @user = User.find params[:user_id]
            error!({error: 'User not found', status: 'Fail'}, 200) unless @user
            @user_working_environments = @user.user_environments
          end

          #for delete work environment

      desc "Delete Work Environment"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :work_env_id
      end

      get :delete_work_env do
        @work_env = UserEnvironment.find params[:work_env_id]
        @work_env.destroy
        { code: 200, :status => "Success" }
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
            post :references, jbuilder: 'android' do
              @user = User.find params[:user_id]
              error!({error: 'User not found', status: 'Fail'}, 200) unless @user
              @reference = UserReference.new user_id: @user.id
              if (params[:title] || params[:ref_type] || params[:from] || params[:email] || params[:contact] || params[:date] || params[:location] )
                @reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location)
                @reference.file = params[:file] if params[:file]
                error!({error: @reference.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @reference.save
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
              post :update_references, jbuilder: 'update_android' do
                @reference = UserReference.find params[:reference_id]
                error!({error: 'User Reference not found', status: 'Fail'}, 200) unless @reference
                @reference.attributes = clean_params(params).permit(:title, :ref_type, :from, :email, :contact, :date, :location)
                @reference.file = params[:file] if params[:file]
                error!({error: @reference.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @reference.save
                @reference
              end

            # for get user's references detail

            desc 'Get Users References Detail'
            params do
              requires :token, type: String, regexp: UUID_REGEX
              requires :user_id
            end
            post :get_references, jbuilder: 'listing_android' do
              @user = User.find params[:user_id]
              error!({error: 'User not found', status: 'Fail'}, 200) unless @user
              @user_references = @user.user_references
            end

            #for delete reference

      desc "Delete reference"

      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :reference_id
      end

      get :delete_reference do
        @reference = UserReference.find params[:reference_id]
        @reference.destroy
        { code: 200, :status => "Success" }
      end

      

      
  end
  

  # member end

  # company start
  
  resources :company do 

          # for fill company information

          desc 'Company Information'
            params do
              requires :token, type: String, regexp: UUID_REGEX
              requires :user_id
              requires :company_name
              optional :company_establish_from
              requires :company_industry        
              requires :company_functional_area
              requires :company_address
              requires :company_zipcode
              requires :company_city
              requires :company_contact
              optional :company_skype_id
              requires :company_id
            end
            post :company_info, jbuilder: 'android' do
              @user = User.find params[:user_id]
              error!({error: 'User not found', status: 'Fail'}, 200) unless @user
              if @user.role == 'Company'
                @user.attributes = clean_params(params).permit(:company_name, :company_establish_from, :company_industry, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id, :company_id)
                error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
              else
                error! "Record not found.", 200
              end
            end

          # for company introduction

          desc 'Company Introduction'
            params do
              requires :token, type: String, regexp: UUID_REGEX
              requires :user_id
              optional :company_logo
              optional :company_profile
              optional :company_brochure        
              requires :company_website
              requires :company_facebook_link
            end
            post :corporate_identity, jbuilder: 'android' do
              @user = User.find params[:user_id]
              error!({error: 'User not found', status: 'Fail'}, 200) unless @user
              if @user.role == 'Company'
                @user.attributes = clean_params(params).permit(:company_website, :company_facebook_link)
                error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
                @user.company_logo = params[:company_logo] if params[:company_logo]
                @user.company_profile = params[:company_profile] if params[:company_profile]
                @user.company_brochure = params[:company_brochure] if params[:company_brochure]
              else
                error! "Record not found.", 200
              end
            end

          # for corporate identity

          desc 'Growth And Goal'
            params do
              requires :token, type: String, regexp: UUID_REGEX
              requires :user_id
              optional :company_turnover
              requires :company_no_of_emp
              optional :company_growth_ratio        
              optional :companu_new_ventures
              optional :company_future_turnover
              optional :company_future_new_venture_location
              optional :company_future_outlet
            end
            post :growth_and_goal, jbuilder: 'android' do
              @user = User.find params[:user_id]
              error!({error: 'User not found', status: 'Fail'}, 200) unless @user
              if @user.role == 'Company'
                @user.attributes = clean_params(params).permit(:company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet)
                error!({error: @user.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @user.save
              else
                error! "Record not found.", 200
              end
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
              error!({error: 'User not found', status: 'Fail'}, 200) unless @user
                params[:files].each do |file|
                  @galleries = CompanyGalery.new user_id: params[:user_id]
                  @galleries.file = file
                  error!({error: @galleries.errors.full_messages.join(', '), status: 'Fail'}, 200) unless @galleries.save
                end
                {}
            end


  
   end

  # company end

  # data start
  
  resources :data do 

    # for dropdown data

    desc 'Company Information'
            params do
              requires :token, type: String, regexp: UUID_REGEX
            end
            post :course_and_spe, jbuilder: 'android' do
              @courses = Course.all
              @specializations = Specialization.all
            end

  end

  # data end

end
