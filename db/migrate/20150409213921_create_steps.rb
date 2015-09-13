class CreateSteps < ActiveRecord::Migration
  def change
    create_table :steps do |t|
      t.integer :profile_id
      t.integer :record_id
      t.integer :progression_id

      t.timestamps
    end
  end
end
