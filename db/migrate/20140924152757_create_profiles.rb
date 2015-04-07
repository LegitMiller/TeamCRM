class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.string :title
      t.string :bio
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
