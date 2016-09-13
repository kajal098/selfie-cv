class QuickMessage < ActiveRecord::Base
	validates :text, presence: true
	extend Enumerize
	enum role: { student: false, faculty: true }
	ROLES = {"student" => 0, "faculty" => 1}

	paginates_per 10
	
end
