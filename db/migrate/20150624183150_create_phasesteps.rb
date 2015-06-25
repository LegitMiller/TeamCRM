class CreatePhasesteps < ActiveRecord::Migration
  def change
    create_table :phasesteps do |t|
      t.datetime :finishedtime
      t.integer :record_id
      t.integer :phase_id

      t.timestamps
    end
  end
end
