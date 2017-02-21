class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :contact_info
      t.text   :address
      t.string :contact_person
      t.timestamps null: false
    end
  end
end
