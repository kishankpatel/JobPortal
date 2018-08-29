class AddIsArchiveToJob < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :is_archive, :boolean, default: false
  end
end
