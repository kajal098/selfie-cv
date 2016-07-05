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

    def current_group
      current_user.all_groups
    end

    def authenticate!
      error! 'Unauthorized', 401 unless params[:token] =~ UUID_REGEX
      error! 'Unauthorized', 401 unless current_user
    end

  end

# devices start

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
      post :register, jbuilder: 'all' do
        @user = User.new clean_params(params).permit(:username, :email, :password, :password_confirmation, :role)
        error! 'Device not registered',422 unless current_device
        error! @user.errors.full_messages.join(', '), 422 unless @user.save
      end

    # for user login

    desc 'User login with email and password'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :username
      requires :password
      requires :role
    end
    post :login , jbuilder: 'all' do
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
    post :change_password , jbuilder: 'all' do
      authenticate!
      @user = current_user
      error! "Current password is wrong.", 422 unless @user.valid_password? params[:current_password]
      error! "Password not same as previous password", 422 if @user.valid_password?(params[:password])
      @user.attributes = clean_params(params).permit(:password, :password_confirmation)
      error! @user.errors.full_messages.join(', '), 422 unless @user.save
      @user
    end

    

  end

  # member end

  # member profile start

  resources :member_profile do 

    # for fill user resume

    desc 'User Resume'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        requires :title
        requires :first_name
        optional :middle_name
        optional :last_name
        requires :gender
        requires :date_of_birth 
        requires :nationality 
        requires :address 
        requires :city
        requires :zipcode
        requires :contact_number
        requires :education_in  
        requires :school_name 
        requires :year
        optional :course_id
        optional :specialization_id
        optional :year
        optional :school
        optional :skill
        optional :file
      end
      post :resume, jbuilder: 'all' do
        @user = User.find params[:user_id]
        @user.attributes = clean_params(params).permit(:title, :first_name,  :middle_name, :last_name, :gender,  :date_of_birth, :nationality, :address, :city,  :contact_number,  :education_in,  :school_name, :year)
        @user.file = params[:file] if params[:file]
        error! @user.errors.full_messages.join(', '), 422 unless @user.save
        @user_education = UserEducation.new user_id: @user.id, course_id: params[:course_id], specialization_id: params[:specialization_id], year: params[:year], school: params[:school], skill: params[:skill]
        error! @user_education.errors.full_messages.join(', '), 422 unless @user_education.save
      end

    # for fill user awards and certificates

    desc 'User Achievement'
      params do
        requires :token, type: String, regexp: UUID_REGEX
        requires :user_id
        optional :type
        optional :name
        optional :certi_type        
        optional :year
        optional :description
        optional :award_type
        optional :file
      end
      get :achievement, jbuilder: 'all' do
        @user = User.find params[:user_id]
        if params[:type] == 'awards'
          @award = UserAward.new user_id: @user.id, name: params[:name], description: params[:description]
          @award.award_type = params[:award_type] if params[:award_type]
          @award.file = params[:file] if params[:file]
          error! @award.errors.full_messages.join(', '), 200 unless @award.save
        elsif params[:type] == 'certificate'
          @certificate = UserCertificate.new user_id: @user.id, name: params[:name], year: params[:year], certificate_type: params[:certi_type]
          @certificate.file = params[:file] if params[:file]
          error! @certificate.errors.full_messages.join(', '), 200 unless @certificate.save
        end
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
        post :curriculars, jbuilder: 'all' do
          @user = User.find params[:user_id]
          @curricular = UserCurricular.new user_id: @user.id, curricular_type: params[:curricular_type], title: params[:title],team_type: params[:team_type],location: params[:location],date: params[:date]
          @curricular.file = params[:file] if params[:file]
          error! @curricular.errors.full_messages.join(', '), 422 unless @curricular.save          
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
          post :future_goal, jbuilder: 'all' do
            @user = User.find params[:user_id]
            @future_goal = UserFutureGoal.new user_id: @user.id, goal_type: params[:goal_type], title: params[:title],term_type: params[:term_type]
            @future_goal.file = params[:file] if params[:file]
            error! @future_goal.errors.full_messages.join(', '), 422 unless @future_goal.save          
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
            post :working_environment, jbuilder: 'all' do
              @user = User.find params[:user_id]
              @environment = UserEnvironment.new user_id: @user.id, env_type: params[:env_type], title: params[:title]
              @environment.file = params[:file] if params[:file]
              error! @environment.errors.full_messages.join(', '), 422 unless @environment.save          
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
            post :references, jbuilder: 'all' do
              @user = User.find params[:user_id]
              @reference = UserReference.new user_id: @user.id, title: params[:title], ref_type: params[:ref_type], from: params[:from],email: params[:email], contact: params[:contact], date: params[:date], location: params[:location]
              @reference.file = params[:file] if params[:file]
              error! @reference.errors.full_messages.join(', '), 422 unless @reference.save          
            end

      

  end

  # member profile end

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
            post :company_info, jbuilder: 'all' do
              @user = User.find params[:user_id]
              if @user.role == 'Company'
                @user.attributes = clean_params(params).permit(:company_name, :company_establish_from, :company_industry, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id, :company_id)
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
            post :corporate_identity, jbuilder: 'all' do
              @user = User.find params[:user_id]
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
            post :growth_and_goal, jbuilder: 'all' do
              @user = User.find params[:user_id]
              if @user.role == 'Company'
                @user.attributes = clean_params(params).permit(:company_turnover, :company_no_of_emp, :company_growth_ratio, :companu_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet)
                error! @user.errors.full_messages.join(', '), 422 unless @user.save
              else
                error! "Record not found.", 422
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
              @galery = CompanyGalery.new
              @galery.file = params[:file] if params[:file]

              @user = User.find params[:user_id]
                params[:files].each do |file|
                  @galleries = CompanyGalery.new user_id: params[:user_id]
                  @galleries.file = file
                  error! @galleries.errors.full_messages.join(', '), 422 unless @galleries.save
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
            post :course_and_spe, jbuilder: 'all' do
              @courses = Course.all
              @specializations = Specialization.all
            end

  end

  # data end
 

end
