class CreateCandidatesJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates_jobs do |t|
      t.references :candidate, foreign_key: true
      t.references :job, foreign_key: true

      t.timestamps
    end
	add_index :candidates_jobs, [:candidate_id, :job_id], unique: true
  end

end
