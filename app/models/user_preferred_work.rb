class UserPreferredWork < ActiveRecord::Base
	belongs_to :user
	validates :ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type, presence: true
	validates :current_salary, :numericality => true, :allow_nil => true
	validates :expected_salary, :numericality => true, :allow_nil => true
end
