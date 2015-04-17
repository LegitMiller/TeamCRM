class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.datetime :receivedate
      t.string :progress
      t.boolean :phasemail
      t.boolean :progressmail
      t.float :lopay
      t.float :propay
      t.float :jpay
      t.float :opay
      t.integer :loanofficer_id
      t.integer :processor_id

      t.timestamps
    end
  end
end
