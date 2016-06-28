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
      post :register, jbuilder: 'all' do
        @user = User.new clean_params(params).permit(:username, :email, :password, :password_confirmation, :role)
        error! 'Device not registered',422 unless current_device
        error! @user.errors.full_messages.join(', '), 422 unless @user.save
      end

    desc 'User login with email and password'
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :username
      requires :password
      requires :role
    end
    post :login do
      @user = User.find_by username: params[:username]
      error! 'Device not registered',422 unless current_device
      error! 'User not found',422 unless @user
      error! 'Wrong username or password',422 unless @user.valid_password? params[:password]
      current_device.update_column :user_id, @user.id
    end

    desc "Send reset password token"
    post :reset_code do
      authenticate!
      @user = current_user
      @user.update_column :reset_code, (SecureRandom.random_number*1000000).to_i
      UserMailer.send_reset_code(@user).deliver_now
      {}
    end


    desc "Reset Password"
    params do
      requires :token, type: String, regexp: UUID_REGEX
      requires :code, type: String
      requires :password, type: String
      requires :password_confirmation, type: String
    end
    post :reset_password do
      @user = current_user
      error! "Wrong reset code.", 422 unless @user.reset_code == params[:code]
      @user.attributes = clean_params(params).permit(:password, :password_confirmation)
      error! @user.errors.full_messages.join(', '), 422 unless @user.save
      {}
    end

  end

 

end
