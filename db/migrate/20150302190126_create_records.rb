class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :firstname
      t.string :lastname
      t.string :phone
      t.string :email
      t.string :raemail
      t.datetime :receivedate
      t.datetime :followupdate
      t.string :progress
      t.string :detailedprogress
      t.boolean :phasemail
      t.boolean :progressmail
      t.float :lopay
      t.float :propay
      t.float :jpay
      t.float :opay
      t.boolean :splitpay
      t.string :loantype
      t.float :loanquote
      t.float :ratelock
      t.date :ratelockexp
      t.date :purchasesigned
      t.date :contractexp
      t.date :appraisaldue
      t.date :closingdue
      t.date :loanapprovaldue
      t.integer :loanofficer_id
      t.integer :processor_id
      t.integer :marketer_id
      t.integer :real_id
      t.integer :escrow_id

      t.timestamps
    end
  end
end
