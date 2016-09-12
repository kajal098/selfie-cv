class Message < ActiveRecord::Base
	validates :text, presence: true
	extend Enumerize
	enum role: { student: false, faculty: true }
	ROLES = {"student" => 0, "faculty" => 1}
end
