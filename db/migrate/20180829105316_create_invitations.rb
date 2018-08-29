class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.integer :candidate_id
      t.integer :job_id
      t.integer :organization_id
      t.datetime :interview_date
      t.boolean :is_accepted
      t.text :rejected_reason

      t.timestamps
    end
  end
end
