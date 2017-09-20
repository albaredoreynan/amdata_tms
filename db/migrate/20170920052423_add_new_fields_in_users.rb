class AddNewFieldsInUsers < ActiveRecord::Migration
  def change
  	add_column :users, :rate_per_hour, :decimal
  	add_column :users, :role_type, :string
  end
end
