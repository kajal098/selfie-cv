class Admin::UsersController < Admin::ApplicationController

  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @report = UserReport.new params[:user_report]
    @assets = @report.assets
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.welcome(@user,params[:user][:password]).deliver_now
      redirect_to admin_users_path, notice: "De inspecteur is succesvol gecreëerd."
    else
      render action: :new
    end
  end

  def show

  end

  def edit    
  end

  def update    
    if @user.update user_params
      redirect_to admin_users_path, notice: "De inspecteur is succesvol bijgewerkt."
    else
      render action: :edit
    end
  end

  def destroy
    begin
      @user.destroy
      redirect_to admin_users_path, notice: "De inspecteur is succesvol verwijderd."
    rescue Exception => e      
      redirect_to admin_users_path, alert: e.message
    end
  end

  

private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    if params[:action] == "update" and params[:user] and params[:user][:password].blank?
      params.require(:user).permit( :name, :email, :phone_number)
    else
      params.require(:user).permit!
    end
  end

end