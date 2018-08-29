class CandidatesJob < ApplicationRecord
  belongs_to :candidate
  belongs_to :job
end
