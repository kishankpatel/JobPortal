class AddIsApproveToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :is_approve, :boolean, default: false
  end
end
