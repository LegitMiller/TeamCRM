class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :comment
      t.integer :user_id
      t.integer :record_id

      t.timestamps
    end
  end
end
