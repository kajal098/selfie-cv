class Marketiq < ActiveRecord::Base

	validates :question, :option_a, :option_b, :option_c, :option_d, :answer, presence: true

	paginates_per 10

end
