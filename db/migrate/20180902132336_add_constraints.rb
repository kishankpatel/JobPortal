class AddConstraints < ActiveRecord::Migration[5.2]
  def change
  	change_column :organizations, :name, :string, null: false
  	change_column :jobs, :title, :string, null: false
  	change_column :jobs, :title, :string, null: false
  	change_column :candidates, :name, :string, null: false
  	change_column :candidates, :email, :string, null: false

  end
end
