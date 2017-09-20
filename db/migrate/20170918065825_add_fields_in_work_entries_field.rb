class AddFieldsInWorkEntriesField < ActiveRecord::Migration
  def change
  	add_column :work_entries, :tasks, :text
  	add_column :work_entries, :status, :string
  	add_column :work_entries, :machine_name, :string
  	add_column :work_entries, :remarks, :text
  	add_column :work_entries, :active_user, :string

  	add_column :users, :job_title, :string
  end
end
