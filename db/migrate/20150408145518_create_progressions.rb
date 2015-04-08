class CreateProgressions < ActiveRecord::Migration
  def change
    create_table :progressions do |t|
      t.string :name
      t.integer :phase_id

      t.timestamps
    end
  end
end
