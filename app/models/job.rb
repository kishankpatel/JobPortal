class Job < ApplicationRecord

	belongs_to :user
	belongs_to :organization
	has_many :candidates_jobs
	has_many :candidates, through: :candidates_jobs
	default_scope {where(:is_archive => false)}
	scope :approved, -> { where(is_approve: true) }
	def creator
		self.user.email	
	end
	def created
		self.created_at.strftime("%m/%d/%Y %H:%M")
	end
end