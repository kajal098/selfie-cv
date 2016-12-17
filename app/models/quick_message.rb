class QuickMessage < ActiveRecord::Base
	validates :text, presence: { message: "Text must be filled" }
	extend Enumerize
	enum role: { student: false, faculty: true }
	ROLES = {"student" => 0, "faculty" => 1}

	paginates_per 7
	
end
