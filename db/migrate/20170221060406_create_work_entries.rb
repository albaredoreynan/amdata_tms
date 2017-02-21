class CreateWorkEntries < ActiveRecord::Migration
  def change
    create_table :work_entries do |t|
      t.datetime   :entry_date
      t.integer    :client_id
      t.string     :time_in
      t.string     :time_out
      t.text       :details
      t.integer    :user_id
      t.timestamps null: false
    end
  end
end
