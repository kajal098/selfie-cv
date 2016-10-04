#require 'elasticsearch/model'

class User < ActiveRecord::Base

extend Enumerize
enum role: { Admin: 0, Student: 1, Faculty: 2, Jobseeker:3, Company:4 }

scope :for_roles, ->(values) do
    return all if values.blank?

    where(role: roles.values_at(*Array(values)))
  end

devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :trackable

after_save :percent_of_resume

validates :username,presence: true, uniqueness: { case_sensitive: false }
validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

#validates :username, length: { minimum: 6 }
#validates :username, length: { maximum: 20 }
#validates :username, length: { in: 6..20 }
#validates :username, length: { is: 6 }

paginates_per 10

has_many    :devices
has_many    :courses
has_many    :specializations
belongs_to  :company
belongs_to  :industry
has_many    :user_educations
has_many    :student_educations
has_many    :user_experiences
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

def self.to_csv(options = {})
    CSV.generate(options) do |csv|
        csv << column_names
        all.each do |user|
            csv << user.attributes.values_at(*column_names)
        end
    end
end

def percent_of_resume()

    if self.user_meter.blank?
        user_meter = UserMeter.create(:user_id=>self.id)
    else
        user_meter = self.user_meter
    end
        if self.file_type.present?  
            resume_info_per = 0
            setting_per = UserPercentage.find_by_key('resume_info')
            if self.file_type == "doc"
                resume_info_per = setting_per.value.to_i * 0.5
            elsif self.file_type == "image"
                resume_info_per = setting_per.value.to_i * 0.5
            elsif self.file_type == "audio"
                resume_info_per = setting_per.value.to_i * 0.7
            elsif self.file_type == "video"
                resume_info_per = setting_per.value.to_i * 1
            else
                resume_info_per = setting_per.value.to_i * 0.3
            end
        user_meter.update_column('resume_info_per' ,resume_info_per)
        end 
        return true
end

def profile_meter_total
    if self.role == "Jobseeker"
        setting_per = UserPercentage.where(key: 'resume').where(ptype: "Jobseeker").first
        resume_per = self.user_meter.resume_info_per + self.user_meter.education_per + self.user_meter.experience_per
        resume_per = (resume_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('resume_per' ,resume_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Jobseeker").first
        achievement_per = self.user_meter.award_per + self.user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = self.user_meter.resume_per + self.user_meter.achievement_per + self.user_meter.curri_per + self.user_meter.whizquiz_per + self.user_meter.future_goal_per + self.user_meter.working_env_per + self.user_meter.ref_per
        self.user_meter.update_column('profile_meter_per' ,total)  
        
    elsif self.role == "Company"

        setting_per = UserPercentage.where(key: 'growth').where(ptype: "Company").first
        growth_and_goal_per = self.user_meter.evalution_per + self.user_meter.future_goal_per
        growth_and_goal_per = (growth_and_goal_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('growth_and_goal_per' ,growth_and_goal_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Company").first
        achievement_per = self.user_meter.award_per + self.user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = self.user_meter.company_info_per + self.user_meter.corporate_identity_per + self.user_meter.growth_and_goal_per + self.user_meter.achievement_per + self.user_meter.galery_per + self.user_meter.working_env_per
        self.user_meter.update_column('profile_meter_per' ,total)  
        
    elsif self.role == "Student"

        setting_per = UserPercentage.where(key: 'education').where(ptype: "Student").first
        student_education_per = self.user_meter.student_education_info_per + self.user_meter.student_marksheet_per + self.user_meter.student_project_per
        student_education_per = (student_education_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('student_education_per' ,student_education_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Student").first
        achievement_per = self.user_meter.award_per + self.user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = self.user_meter.student_basic_info_per + self.user_meter.student_education_per + self.user_meter.achievement_per + self.user_meter.curri_per + self.user_meter.future_goal_per
        self.user_meter.update_column('profile_meter_per' ,total)
        
    elsif self.role == "Faculty"

        setting_per = UserPercentage.where(key: 'experience').where(ptype: "Faculty").first
        experience_per = self.user_meter.faculty_affiliation_per + self.user_meter.faculty_workshop_per + self.user_meter.faculty_publication_per + self.user_meter.faculty_research_per
        experience_per = (experience_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('experience_per' ,experience_per)

        setting_per = UserPercentage.where(key: 'achievement').where(ptype: "Faculty").first
        achievement_per = self.user_meter.award_per + self.user_meter.certificate_per
        achievement_per = (achievement_per.to_i * setting_per.value.to_i) / 100
        self.user_meter.update_column('achievement_per' ,achievement_per)  
        
        total = self.user_meter.faculty_basic_info_per + self.user_meter.achievement_per + self.user_meter.experience_per
        self.user_meter.update_column('profile_meter_per' ,total)
        
    end
    return true
end

def like_per
        @count = self.likes.count
        setting_per = UserPercentage.find_by_key('like').value
        @like_per = 0
        if @count >= 100 && @count <= 300
            @like_per = setting_per * 0.3
        elsif @count >= 300 &&  @count <= 500
            @like_per = setting_per * 0.5
        elsif @count >= 500
            @like_per = setting_per * 1
        end
        return @like_per        
end

def view_per
        @count = self.views.count
        setting_per = UserPercentage.find_by_key('viewed').value
        @view_per = 0
        if @count >= 100 && @count <= 300
            @view_per = setting_per * 0.5
        elsif @count >= 300
            @view_per = setting_per * 1
        end
        return @view_per        
end

def share_per
        @count = self.shares.count
        setting_per = UserPercentage.find_by_key('share').value
        @share_per = 0
        if @count >= 100 && @count <= 300
            @share_per = setting_per * 0.5
        elsif @count >= 300
            @share_per = setting_per * 1
        end
        return @share_per        
end

def bronze_per
        @count = self.bronze_rates.count
        setting_per = UserPercentage.find_by_key('star').value
        bronze_setting_per = setting_per.to_f * 0.2
        @bronze_per = 0
        if @count >= 100 && @count <= 300
            @bronze_per = @count * bronze_setting_per * 0.004
        elsif @count >= 300
            @bronze_per = bronze_setting_per * 1
        end
        return @bronze_per       
end
def silver_per
        @count = self.silver_rates.count
        setting_per = UserPercentage.find_by_key('star').value
        silver_setting_per = setting_per.to_f * 0.3
        @silver_per = 0
        if @count >= 100 && @count <= 300
            @silver_per = @count * silver_setting_per * 0.004
        elsif @count >= 300
            @silver_per = silver_setting_per * 1
        end
        return @silver_per        
end
def gold_per
        @count = self.gold_rates.count
        setting_per = UserPercentage.find_by_key('star').value
        gold_setting_per = setting_per.to_f * 0.5
        @gold_per = 0
        if @count >= 100 && @count <= 300
            @gold_per = @count * gold_setting_per * 0.004
        elsif @count >= 300
            @gold_per = silver_setting_per * 1
        end
        return @gold_per        
end
def rate_per
        total = (self.bronze_per + self.silver_per + self.gold_per).round(2)
        return total     
end

def cal_total_per
        total = self.like_per + self.view_per + self.share_per + self.rate_per + self.user_meter.profile_meter_per + 0 + 0 + 0
        self.user_meter.update_column('total_per' ,total)          
        self.update_column('total_per' ,total)     
    return total
end



end
