class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.integer :organization_id

      t.timestamps
    end
  end
end
