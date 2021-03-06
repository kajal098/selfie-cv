class User < ActiveRecord::Base

extend Enumerize
enum role: { Admin: 0, Student: 1, Faculty: 2, Jobseeker:3, Company:4 }
ROLES = { "Student" => 1, "Faculty" => 2, "Jobseeker" => 3, "Company" => 4 }

scope :for_roles, ->(values) do
    return all if values.blank?
    where(role: roles.values_at(*Array(values)))
end

devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

validates :username,presence: true, uniqueness: { case_sensitive: false }
validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

paginates_per 10

has_many    :devices
has_many    :active_devices, -> { where.not(registration_id: nil) }, class_name: 'Device'
has_many    :courses
has_many    :specializations
belongs_to  :company
belongs_to  :industry
belongs_to  :company_stock, class_name: 'CompanyStock',foreign_key: "country_id"
has_many    :user_educations
has_many    :student_educations
has_many    :user_experiences
has_many    :total_experiences, -> { self.total_experiences.sum }, class_name: 'UserExperience'
has_many    :user_preferred_works
has_many    :user_awards
has_many    :user_certificates
has_many    :user_curriculars
has_many    :user_future_goals
has_many    :user_environments
has_many    :user_references
has_many    :company_galeries, class_name: 'CompanyGalery',foreign_key: "user_id"
has_many    :user_marksheets
has_one     :user_meter
has_many    :user_projects
has_many    :faculty_affiliations
has_many    :faculty_workshops
has_many    :faculty_publications
has_many    :faculty_researches
has_many    :user_whizquizzes
has_many    :user_marketiqs
has_many    :user_folders, class_name: 'UserFolder',foreign_key: "user_id"
belongs_to  :stock_country, class_name: 'StockCountry',foreign_key: "country_id"

has_many    :groups, class_name: 'GroupUser',foreign_key: "user_id"
has_many    :all_groups, -> (user) { where("#{user.id} != ALL (deleted_from)") }, through: :groups, class_name: 'Group', source: :group

has_many    :user_likes
has_many    :likes, class_name: 'UserLike',foreign_key: "like_id"
has_many    :user_views
has_many    :views, class_name: 'UserView',foreign_key: "view_id"
has_many    :user_shares
has_many    :shares, class_name: 'UserShare',foreign_key: "share_id"
has_many    :user_favourites
has_many    :favourites, class_name: 'UserFavourite',foreign_key: "favourite_id"
has_many    :user_rates
has_many    :rates, class_name: 'UserRate',foreign_key: "rate_id"
has_many    :bronze_rates, -> {where(rate_type: 0) }, class_name: 'UserRate',foreign_key: "rate_id"
has_many    :silver_rates, -> {where(rate_type: 1)}, class_name: 'UserRate',foreign_key: "rate_id"
has_many    :gold_rates, -> {where(rate_type: 2) }, class_name: 'UserRate',foreign_key: "rate_id"

# search configuration
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings do
      indexes :name, analyzer: :english, boost: 10
      indexes :specializations, analyzer: :english, boost: 5
      indexes :courses, analyzer: :english, boost: 4
      indexes :role, index: :not_analyzed
      indexes :city, index: :not_analyzed
      indexes :country_id, index: :not_analyzed
      indexes :age, index: :not_analyzed
      indexes :gender, index: :not_analyzed
      indexes :salary, index: :not_analyzed
      indexes :views, index: :not_analyzed
      indexes :rating, index: :not_analyzed
      indexes :job_type, index: :not_analyzed
    end
  end

  def as_indexed_json opts = {}
    opts[:only] = [:id, :role, :first_name, :email, :country_id, :gender]
    ret = as_json(opts)

    suggest = 
    ret.merge!(
      suggest: { 
        input: first_name + middle_name + last_name,
        output: first_name, 
        payload: {  } 
      },
      age: age(date_of_birth),
      salary: user_preferred_works.minimum(:expected_salary),
      views: views.count,
      rating: rates.count,
      job_type: user_preferred_works.map(&:time_type),
      # price: prices.minimum(:price),
      # menu_path: menu_path(restaurant.slug, menu.id, menu.name.parameterize),
      # restaurant_path: restaurant_path(restaurant.slug),
      specializations: user_educations.map{|e| e.specialization ? e.specialization.name : ""},
      courses: user_educations.map{|e| e.course ? e.course.name : ""},
      # city: restaurant.localities.map(&:city_id)
    )
    #ret[:boost] = ret[:rates] * 3
    ret
  end


def age(dob)
  if dob
    dob = dob.to_time
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end

def self.job_simple_search
    
end

def top_joseekers
    User.joins(:user_meter).where(:users=> { role: 3 }).order("user_meters.total_per DESC").limit(3)
end

def top_companies
    User.joins(:user_meter).where(:users=> { role: 4 }).order("user_meters.total_per DESC").limit(3)
end

def top_students
    User.joins(:user_meter).where(:users=> { role: 1 }).order("user_meters.total_per DESC").limit(3)
end

def top_faculties
    User.joins(:user_meter).where(:users=> { role: 2 }).order("user_meters.total_per DESC").limit(3)
end

def top_rated
    User.includes(:user_likes).order("user.user_likes.count DESC").limit(3)
end


mount_uploader :file, FileUploader
def resume_thumb_url; file.url(:thumb); end
def resume_photo_url; file.url; end

mount_uploader :profile_pic, FileUploader
def profile_thumb_url; profile_pic.url(:thumb); end
def profile_photo_url; profile_pic.url; end

mount_uploader :company_logo, FileUploader
def logo_thumb_url; company_logo.url(:thumb); end
def logo_photo_url; company_logo.url; end

mount_uploader :company_profile, FileUploader
def company_profile_thumb_url; company_profile.url(:thumb); end
def company_profile_photo_url; company_profile.url; end

mount_uploader :company_brochure, FileUploader
def brochure_thumb_url; company_brochure.url(:thumb); end
def brochure_photo_url; company_brochure.url; end

mount_uploader :back_profile, FileUploader
def back_profile_thumb_url; back_profile.url(:thumb); end
def back_profile_photo_url; back_profile.url; end

def self.to_csv(options = {})
    CSV.generate(options) do |csv|
        csv << column_names
        all.each do |user|
            csv << user.attributes.values_at(*column_names)
        end
    end
end

# def self.to_csv(options = {})
#     CSV.generate(options) do |csv|
#         csv << ["ID", "User name" "Updated At"]
#         all.each do |user|
#             csv << [user.id, user.username, user.updated_at]
#         end
#     end
# end


# Start Percentage Module

after_save :create_user_meter,
:percent_of_resume,
:percent_of_student_basic_info,
:percent_of_company_info, 
:percent_of_company_future_goal, 
:percent_of_company_evaluation,
:percent_of_faculty_basic_info, 
:percent_of_company_corporate_identity, 
:profile_meter_total, :like_per,
:view_per, :share_per, :bronze_per, 
:silver_per, 
:gold_per, 
:rate_per, 
:update_info_per, 
:cal_total_per


def create_user_meter
    if self.user_meter.blank?
        @user_meter = UserMeter.create(:user_id=>self.id)
    else
        @user_meter = self.user_meter
    end
    return true
end

# Resume Percentage Function

def percent_of_resume
            if self.role == 'Jobseeker'
                resume_info_per = 0
                setting_per = UserPercentage.where(key: 'resume_info').where(ptype: "Jobseeker").first.value.to_i 
                if self.file_type == "video"
                    resume_info_per = setting_per * 1
                elsif self.file_type == "audio"
                    resume_info_per = setting_per * 0.7
                elsif self.file_type == "image"
                    resume_info_per = setting_per * 0.5
                elsif self.file_type == "doc"
                    resume_info_per = setting_per * 0.5             
                elsif self.first_name.present?
                    resume_info_per = setting_per * 0.3
                end
                @user_meter.update_column('resume_info_per' ,resume_info_per)
            end
                
        return true
end

def percent_of_student_basic_info
        if self.role == 'Student' && self.first_name.present?
            student_basic_info_per = 0
            setting_per = UserPercentage.where(key: 'info').where(ptype: "Student").first
            student_basic_info_per = setting_per.value.to_i * 1
            @user_meter.update_column('student_basic_info_per' ,student_basic_info_per)
        end 
        return true
end

def percent_of_company_info
        if self.company_name.present? && self.role == 'Company'   
            company_info_per = 0
            setting_per = UserPercentage.where(key: 'info').where(ptype: "Company").first            
            company_info_per = setting_per.value.to_i * 1            
            @user_meter.update_column('company_info_per' ,company_info_per)                            
        end 
        return true
end

def percent_of_company_corporate_identity
        if self.company_logo_type.present? && self.role == 'Company'   
            corporate_identity_per = 0
            setting_per = UserPercentage.where(key: 'corporate').where(ptype: "Company").first            
            corporate_identity_per = setting_per.value.to_i * 1            
            @user_meter.update_column('corporate_identity_per' ,corporate_identity_per)                            
        end 
        return true
end

def percent_of_company_future_goal
        if self.company_future_turnover.present? && self.role == 'Company'   
            future_goal_per = 0
            setting_per = UserPercentage.where(key: 'info').where(ptype: "Company").first            
            future_goal_per = setting_per.value.to_i * 1            
            @user_meter.update_column('future_goal_per' ,future_goal_per)                            
        end 
        return true
end

def percent_of_company_evaluation
        if self.company_turnover.present? && self.role == 'Company'   
            evalution_per = 0
            setting_per = UserPercentage.where(key: 'info').where(ptype: "Company").first            
            evalution_per = setting_per.value.to_i * 1            
            @user_meter.update_column('evalution_per' ,evalution_per)                            
        end 
        return true
end

def percent_of_faculty_basic_info
        if self.first_name.present? && self.role == 'Faculty'  
            faculty_basic_info_per = 0
            setting_per = UserPercentage.where(key: 'info').where(ptype: "Faculty").first
            faculty_basic_info_per = setting_per.value.to_i * 1
            @user_meter.update_column('faculty_basic_info_per' ,faculty_basic_info_per)
        end 
        return true
end

def profile_meter_total
    self.create_user_meter unless @user_meter
    if self.role == "Jobseeker"
        setting_per = UserPercentage.where(key: 'resume').where(ptype: "Jobseeker").first
        resume_per = @user_meter.resume_info_per + @user_meter.education_per + @user_meter.experience_per + @user_meter.prework_per
        resume_per = (resume_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('resume_per' ,resume_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Jobseeker").first
        achievement_per = @user_meter.award_per + @user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = @user_meter.resume_per + @user_meter.achievement_per + @user_meter.curri_per + @user_meter.whizquiz_per + @user_meter.future_goal_per + @user_meter.working_env_per + @user_meter.ref_per
        @user_meter.update_column('profile_meter_per' ,total)  
        
    elsif self.role == "Company"

        setting_per = UserPercentage.where(key: 'growth').where(ptype: "Company").first
        growth_and_goal_per = @user_meter.evalution_per + @user_meter.future_goal_per
        growth_and_goal_per = (growth_and_goal_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('growth_and_goal_per' ,growth_and_goal_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Company").first
        achievement_per = @user_meter.award_per + @user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = @user_meter.company_info_per + @user_meter.corporate_identity_per + @user_meter.growth_and_goal_per + @user_meter.achievement_per + @user_meter.galery_per + @user_meter.working_env_per
        @user_meter.update_column('profile_meter_per' ,total)  
        
    elsif self.role == "Student"

        setting_per = UserPercentage.where(key: 'education').where(ptype: "Student").first
        student_education_per = @user_meter.student_education_info_per + @user_meter.student_marksheet_per + @user_meter.student_project_per
        student_education_per = (student_education_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('student_education_per' ,student_education_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Student").first
        achievement_per = @user_meter.award_per + @user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = @user_meter.student_basic_info_per + @user_meter.student_education_per + @user_meter.achievement_per + @user_meter.curri_per + @user_meter.future_goal_per
        @user_meter.update_column('profile_meter_per' ,total)
        
    elsif self.role == "Faculty"

        setting_per = UserPercentage.where(key: 'experience').where(ptype: "Faculty").first
        experience_per = @user_meter.faculty_affiliation_per + @user_meter.faculty_workshop_per + @user_meter.faculty_publication_per + @user_meter.faculty_research_per
        experience_per = (experience_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('experience_per' ,experience_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Faculty").first
        achievement_per = @user_meter.award_per + @user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        @user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = @user_meter.faculty_basic_info_per + @user_meter.achievement_per + @user_meter.experience_per
        @user_meter.update_column('profile_meter_per' ,total)
        
    end
    return true
end

def like_per
        @count = self.likes.count
        setting_per = UserPercentage.find_by_key('like').value.to_i
        @like_per = 0
        if @count >= UserPercentage.find_by_key('like_first').value.to_i && @count <= UserPercentage.find_by_key('like_second').value.to_i
            @like_per = setting_per * 0.3
        elsif @count >= UserPercentage.find_by_key('like_second').value.to_i &&  @count <= UserPercentage.find_by_key('like_third').value.to_i
            @like_per = setting_per * 0.5
        elsif @count >= UserPercentage.find_by_key('like_third').value.to_i
            @like_per = setting_per * 1
        end
        @user_meter.update_column('like_per' ,@like_per)    
end

def view_per
        @count = self.views.count
        setting_per = UserPercentage.find_by_key('viewed').value.to_i
        @view_per = 0
        if @count >= UserPercentage.find_by_key('view_first').value.to_i && @count <= UserPercentage.find_by_key('view_second').value.to_i
            @view_per = setting_per * 0.5
        elsif @count >= UserPercentage.find_by_key('view_second').value.to_i
            @view_per = setting_per * 1
        end
        @user_meter.update_column('view_per' ,@view_per)            
end

def share_per
        @count = self.shares.count
        setting_per = UserPercentage.find_by_key('share').value.to_i
        @share_per = 0
        if @count >= UserPercentage.find_by_key('share_first').value.to_i && @count <= UserPercentage.find_by_key('share_second').value.to_i
            @share_per = setting_per * 0.5
        elsif @count >= UserPercentage.find_by_key('share_second').value.to_i
            @share_per = setting_per * 1
        end
        @user_meter.update_column('share_per' ,@share_per)    
end

def bronze_per
        @count = self.bronze_rates.count
        setting_per = UserPercentage.find_by_key('star').value.to_i
        bronze_setting_per = setting_per.to_f * 0.2
        @bronze_per = 0
        if @count >= UserPercentage.find_by_key('star_first').value.to_i && @count <= UserPercentage.find_by_key('star_second').value.to_i 
            @bronze_per = @count * bronze_setting_per * 0.004
        elsif @count >= UserPercentage.find_by_key('star_second').value.to_i 
            @bronze_per = bronze_setting_per * 1
        end
        @user_meter.update_column('bronze_per' ,@bronze_per)    
end
def silver_per
        @count = self.silver_rates.count
        setting_per = UserPercentage.find_by_key('star').value.to_i
        silver_setting_per = setting_per.to_f * 0.3
        @silver_per = 0
        if @count >= UserPercentage.find_by_key('star_first').value.to_i && @count <= UserPercentage.find_by_key('star_second').value.to_i 
            @silver_per = @count * silver_setting_per * 0.004
        elsif @count >= UserPercentage.find_by_key('star_second').value.to_i 
            @silver_per = silver_setting_per * 1
        end
        @user_meter.update_column('silver_per' ,@silver_per)    
end
def gold_per
        @count = self.gold_rates.count
        setting_per = UserPercentage.find_by_key('star').value.to_i
        gold_setting_per = setting_per.to_f * 0.5
        @gold_per = 0
        if @count >= UserPercentage.find_by_key('star_first').value.to_i && @count <= UserPercentage.find_by_key('star_second').value.to_i 
            @gold_per = @count * gold_setting_per * 0.004
        elsif @count >= UserPercentage.find_by_key('star_second').value.to_i 
            @gold_per = silver_setting_per * 1
        end
        @user_meter.update_column('gold_per' ,@gold_per)    
end
def rate_per
        @rate_per = (@user_meter.bronze_per + @user_meter.silver_per + @user_meter.gold_per).round(2)
        @user_meter.update_column('rate_per' ,@rate_per)    
end

def update_info_per
    @count = self.update_cv_count
    setting_per = UserPercentage.find_by_key('updateinfo').value.to_i
        @update_info_per = 0
        if @count >= UserPercentage.find_by_key('update_first').value.to_i && @count <= UserPercentage.find_by_key('update_second').value.to_i 
            @update_info_per = setting_per * 0.3
        elsif @count >= UserPercentage.find_by_key('update_second').value.to_i &&  @count <= UserPercentage.find_by_key('update_third').value.to_i 
            @update_info_per = setting_per * 0.5
        elsif @count >= UserPercentage.find_by_key('update_third').value.to_i 
            @update_info_per = setting_per * 1
        end
        @user_meter.update_column('update_info_per' ,@update_info_per)    
end

def cal_total_per
        total_per = @user_meter.like_per + @user_meter.rate_per + @user_meter.update_info_per + @user_meter.share_per + @user_meter.view_per + @user_meter.market_iq_per + @user_meter.stock_exchange_per + @user_meter.profile_meter_per
        @user_meter.update_column('total_per' ,total_per)          
    return true
end


def cal_preview_per(user_per ,per_type)
    setting_per = UserPercentage.where(key: per_type).where(ptype: self.role).first
    @preview_per = ((user_per * 100) / setting_per.value.to_i)
    return @preview_per
end    


end
