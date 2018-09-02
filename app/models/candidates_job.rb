class CandidatesJob < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
  validates :candidate_id, presence: true, uniqueness: { scope: :job_id }
end
