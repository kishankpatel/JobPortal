class Job < ApplicationRecord

	belongs_to :user
	belongs_to :organization
	has_many :candidates_jobs
	has_many :candidates, through: :candidates_jobs
	has_many :invitations
	
	validates :title, presence: true

	default_scope {where(:is_archive => false)}
	scope :approved, -> { where(is_approve: true) }
	
	def creator
		self.user.email	
	end
	def created
		self.created_at.strftime("%m/%d/%Y %H:%M %p")
	end

	def self.to_csv(options = {})
	  CSV.generate(options) do |csv|
	    csv << column_names
	    all.each do |product|
	      csv << product.attributes.values_at(*column_names)
	    end
	  end
	end
end