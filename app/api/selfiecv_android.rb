require 'api_logger'

class SelfiecvAndroid < Grape::API

  use ApiLogger
  
  version 'android', using: :path
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

# devices start

  resources :devices do

    desc 'Register device after notification service subscription'
    params do
      requires :uuid, type: String, regexp: UUID_REGEX
      optional :registration_id, type: String
    end
    post :register do
      #render status: 200
      #render :nothing => true, :status => 200
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
    post :change_password  , jbuilder: 'all' do
      authenticate!
      @user = current_user
      error! "Current password is wrong.", 422 unless @user.valid_password? params[:current_password]
      error! "Password not same as previous password", 422 if @user.valid_password?(params[:password])
      @user.attributes = clean_params(params).permit(:password, :password_confirmation)
      error! @user.errors.full_messages.join(', '), 422 unless @user.save
      @user
    end

  

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
        optional :file
      end
      post :achievement, jbuilder: 'all' do
        @user = User.find params[:user_id]
        if params[:type] == 'awards'
          @award = UserAward.new user_id: @user.id, name: params[:name], description: params[:description]
          @award.file = params[:file] if params[:file]
          error! @award.errors.full_messages.join(', '), 422 unless @award.save
        elsif params[:type] == 'certificate'
          @certificate = UserCertificate.new user_id: @user.id, name: params[:name], year: params[:year], certificate_type: params[:certi_type]
          @certificate.file = params[:file] if params[:file]
          error! @certificate.errors.full_messages.join(', '), 422 unless @certificate.save
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

      

      
  end
  

  # member end
 

end
