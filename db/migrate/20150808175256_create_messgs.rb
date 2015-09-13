class CreateMessgs < ActiveRecord::Migration
  def change
    create_table :messgs do |t|
      t.text :intro
      t.text :message
      t.text :closing
      t.boolean :admin
      t.boolean :master
      t.boolean :coborrower
      t.boolean :borrower
      t.boolean :processor
      t.boolean :realtor
      t.boolean :loanofficer
      t.boolean :escrowofficer
      t.boolean :marketer
      t.integer :progression_id

      t.timestamps
    end
  end
end
