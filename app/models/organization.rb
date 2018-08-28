class Organization < ApplicationRecord
	validates :name, uniqueness: true
	has_many :users
	has_many :jobs
end
