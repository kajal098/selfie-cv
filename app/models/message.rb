class Message < ActiveRecord::Base
	validates :text, presence: true
	extend Enumerize
	enum role: { student: false, faculty: true }
end
