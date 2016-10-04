class Whizquiz < ActiveRecord::Base

	validates :question, :answer, presence: true

end
