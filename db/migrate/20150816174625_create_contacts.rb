class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.boolean :useme
      t.string :contacttype
      t.string :firstname
      t.string :lastname
      t.boolean :useemail
      t.string :email
      t.boolean :usephone
      t.string :phone
      t.string :other
      t.integer :record_id
      t.integer :profile_id

      t.timestamps
    end
  end
end
