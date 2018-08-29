class Invitation < ApplicationRecord
	belongs_to :candidate
	belongs_to :organization
	belongs_to :job
end
