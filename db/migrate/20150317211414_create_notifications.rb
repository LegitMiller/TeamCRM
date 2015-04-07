class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :maker_id
      t.integer :user_id
      t.integer :thirdparty_id
      t.integer :record_id
      t.string :changetype
      t.string :change
      t.boolean :seen
      t.timestamps
    end
  end
end
