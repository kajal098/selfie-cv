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

#after_save :percent_of_resume

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

has_many    :groups, class_name: 'GroupUser',foreign_key: "user_id"
has_many    :all_groups, -> (user) { where("#{user.id} != ALL (deleted_from)") }, through: :groups, class_name: 'Group', source: :group

has_many    :user_likes
has_many    :like_counts, class_name: 'UserLike',foreign_key: "like_id"
has_many    :user_views
has_many    :view_counts, class_name: 'UserView',foreign_key: "view_id"
has_many    :user_shares
has_many    :share_counts, class_name: 'UserShare',foreign_key: "share_id"
has_many    :user_favourites
has_many    :favourite_counts, class_name: 'UserFavourite',foreign_key: "favourite_id"
has_many    :user_rates
has_many    :rate_counts, class_name: 'UserRate',foreign_key: "rate_id"

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

# def percent_of_resume()

#     if self.user_meter.blank?
#         user_meter = UserMeter.create(:user_id=>self.id)
#     else
#         user_meter = self.user_meter
#     end
#         if self.file_type.present?  
#             resume_info_per = 0
#             setting_per = UserPercentage.find_by_key('resume_info')
#             if self.file_type == "doc"
#                 resume_info_per = setting_per.value.to_i * 0.5
#             elsif self.file_type == "image"
#                 resume_info_per = setting_per.value.to_i * 0.5
#             elsif self.file_type == "audio"
#                 resume_info_per = setting_per.value.to_i * 0.7
#             elsif self.file_type == "video"
#                 resume_info_per = setting_per.value.to_i * 1
#             else
#                 resume_info_per = setting_per.value.to_i * 0.3
#             end
#         user_meter.update_column('resume_info_per' ,resume_info_per)
#         end 
#         return true
# end

def profile_meter_total()
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
        @count = self.like_counts.count
        @per = 0
        if (" @count >= 1 AND  @count <= 10")
            @per = 100
        elsif (" @count >= 10 AND  @count <= 100")
            @per = 200
        end
        return @per
        
end

def profile_meter_total()
        total = 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8
        self.user_meter.update_column('total_per' ,total)          
        self..update_column('total_per' ,total)     
    return true
end



end
