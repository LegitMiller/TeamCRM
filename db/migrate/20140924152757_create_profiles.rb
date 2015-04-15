class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :title
      t.string :bio
      t.boolean :phasemail
      t.boolean :progressmail
      t.boolean :assignmail
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
