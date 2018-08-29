class Candidate < ApplicationRecord
	has_many :candidates_jobs
	has_many :jobs, through: :candidates_jobs
end
