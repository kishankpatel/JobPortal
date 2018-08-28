class Job < ApplicationRecord

	belongs_to :user
	def creator
		self.user.email	
	end
end
