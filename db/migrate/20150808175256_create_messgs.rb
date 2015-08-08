class CreateMessgs < ActiveRecord::Migration
  def change
    create_table :messgs do |t|
      t.string :intro
      t.string :message
      t.string :closing
      t.integer :progression_id

      t.timestamps
    end
  end
end
